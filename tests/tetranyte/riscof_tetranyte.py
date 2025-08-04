import os
import subprocess
import glob
import traceback
from pathlib import Path

class tetranyte:
    # required by RISCOF for display
    __model__ = "tetranyte"

    def __init__(self, name, config, config_dir):
        self.name       = name
        self.config_dir = Path(config_dir)

        # from config.ini [tetranyte]
        self.pluginpath     = config["pluginpath"]
        self.isa_spec       = config["ispec"]
        self.platform_spec  = config["pspec"]
        self.verilog_path   = config["verilog"]
        self.prefix         = config.get("prefix", "")
        self.top            = config["top"]

        # will be set in build()
        self.sim            = None
        self.obj_dir        = None
        self.env            = None

    def initialise(self, suite, work_dir, archtest_env):
        self.suite    = suite
        self.work_dir = Path(work_dir)
        self.obj_dir  = self.work_dir / "obj_dir"
        os.makedirs(self.obj_dir, exist_ok=True)
        self.env     = os.environ.copy()

        print(f"[tetranyte] initialise called")
        print(f"  suite    = {self.suite}")
        print(f"  work_dir = {self.work_dir}")
        print(f"  env      = {archtest_env}")
        print(f"  isa_spec = {self.isa_spec}")
        print(f"  pspec    = {self.platform_spec}")

    def build(self, isa_spec, platform_spec):
        """
        Build the Verilator simulation harness.
        """
        isa_spec      = Path(isa_spec)
        platform_spec = Path(platform_spec)

        print(f"[tetranyte] build:")
        print(f"  isa_spec      = {isa_spec}")
        print(f"  platform_spec = {platform_spec}")
        print(f"  verilog file  = {self.verilog_path}")
        print(f"  top module    = {self.top}")

        # write C++ harness
        harness = f"""
#include <verilated.h>
#include "V{self.top}.h"
#include <fstream>
#include <iostream>

int main(int argc, char **argv) {{
    Verilated::commandArgs(argc, argv);
    V{self.top}* tb = new V{self.top};
    std::ifstream memf(argv[1]);
    uint32_t data, addr = 0;
    while (memf >> std::hex >> data) {{
        tb->memory[addr++] = data;
    }}
    for (int i = 0; i < 1000000; i++) {{
        tb->clock = 0; tb->eval();
        tb->clock = 1; tb->eval();
        if (tb->trap) break;
    }}
    delete tb;
    return 0;
}}
"""
        main_cpp = self.obj_dir / "main.cpp"
        main_cpp.write_text(harness)

        cmd = [
            "verilator",
            "--cc", self.verilog_path,
            "--public-flat-rw",
            "--exe", "--build", str(main_cpp)
        ]
        print(f"[tetranyte] running: {' '.join(cmd)} in {self.obj_dir}")
        subprocess.run(cmd, cwd=self.obj_dir, check=True, env=self.env)

        sim_path = self.obj_dir / f"V{self.top}"
        if not sim_path.exists():
            raise FileNotFoundError(f"Simulator not found at {sim_path}")
        self.sim = str(sim_path)
        print(f"[tetranyte] simulator binary at {self.sim}")

    def runTests(self, testlist):
        for test, info in testlist.items():
            dut_dir = info["work_dir"]
            print(f"\n[tetranyte] ==== running test {test} ====")
            print(f"[tetranyte] DUT work_dir = {dut_dir}")

            # list files
            try:
                entries = os.listdir(dut_dir)
            except Exception as e:
                print(f"[tetranyte] ERROR reading {dut_dir}: {e}")
                entries = []
            print(f"[tetranyte] contents of work_dir: {entries!r}")

            # find .elf
            elf_candidates = glob.glob(os.path.join(dut_dir, "*.elf"))
            print(f"[tetranyte] ELF candidates: {elf_candidates}")
            if not elf_candidates:
                raise FileNotFoundError(
                    f"No .elf found under {dut_dir}\n"
                    f" available files: {entries!r}"
                )
            elf = elf_candidates[0]

            mem = os.path.splitext(elf)[0] + ".mem"
            print(f"[tetranyte] using ELF = {elf}")
            print(f"[tetranyte] expected .mem = {mem}")

            # objcopy → .mem
            objcopy = self.prefix + "objcopy"
            try:
                cp = subprocess.run(
                    [objcopy, "-O", "verilog", elf, mem],
                    check=False,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    env=self.env,
                    text=True
                )
                print(f"[tetranyte] objcopy stdout:\n{cp.stdout}")
                print(f"[tetranyte] objcopy stderr:\n{cp.stderr}")
                cp.check_returncode()
            except Exception as e:
                print(f"[tetranyte] FAILED to objcopy: {e}")
                traceback.print_exc()
                raise

            # run sim
            try:
                simp = subprocess.run(
                    [self.sim, mem],
                    check=False,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    env=self.env,
                    text=True
                )
                print(f"[tetranyte] sim stdout:\n{simp.stdout}")
                print(f"[tetranyte] sim stderr:\n{simp.stderr}")
                simp.check_returncode()
            except Exception as e:
                print(f"[tetranyte] SIM FAILED: {e}")
                traceback.print_exc()
                raise

        print("[tetranyte] all tests passed!")
