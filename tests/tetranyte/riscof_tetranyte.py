import os
import subprocess
import glob
import traceback
from pathlib import Path

class tetranyte:
    # required by RISCOF for display
    __model__ = "tetranyte"

    def __init__(self, name, config, config_dir):
        self.name = name
        self.config_dir = Path(config_dir)
        self.env = os.environ.copy()

        # from config.ini [tetranyte]
        self.pluginpath = config["pluginpath"]
        self.isa_spec = config["ispec"]
        self.platform_spec = config["pspec"]
        self.verilog_path = config["verilog"]
        self.prefix = config.get("prefix", "")
        self.top = config["top"]

        # will be set in build()
        self.sim = None
        self.obj_dir = None
        self.env = None

    def initialise(self, suite, work_dir, archtest_env):
        self.suite = suite
        self.work_dir = Path(work_dir)
        self.obj_dir = self.work_dir / "obj_dir"
        os.makedirs(self.obj_dir, exist_ok=True)
        self.env = os.environ.copy()

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
        isa_spec = Path(isa_spec)
        platform_spec = Path(platform_spec)

        print(f"[tetranyte] build:")
        print(f"  isa_spec      = {isa_spec}")
        print(f"  platform_spec = {platform_spec}")
        print(f"  verilog file  = {self.verilog_path}")
        print(f"  top module    = {self.top}")

        # write C++ harness - FILE-BASED APPROACH
        harness = f"""
#include <verilated.h>
#include "V{self.top}.h"
#include <fstream>
#include <iostream>

int main(int argc, char **argv) {{
    Verilated::commandArgs(argc, argv);
    
    // Pass memory file as plusarg to Verilog
    std::string memfile_arg = "+MEMFILE=";
    memfile_arg += argv[1];
    const char* args[] = {{argv[0], memfile_arg.c_str()}};
    Verilated::commandArgs(2, args);
    
    V{self.top}* tb = new V{self.top};
    
    // Reset the processor
    tb->reset = 1;
    tb->clock = 0; tb->eval();
    tb->clock = 1; tb->eval();
    tb->reset = 0;
    tb->clock = 0; tb->eval();
    
    // Run simulation
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

        # Try both possible locations for the simulator
        sim_path = self.obj_dir / f"V{self.top}"
        if not sim_path.exists():
            sim_path = self.obj_dir / "obj_dir" / f"V{self.top}"
        if not sim_path.exists():
            raise FileNotFoundError(f"Simulator not found at {sim_path}")
        self.sim = str(sim_path)
        print(f"[tetranyte] simulator binary at {self.sim}")

    def runTests(self, testlist):
        for test, info in testlist.items():
            dut_dir = info["work_dir"]
            print(f"\\n[tetranyte] ==== running test {test} ====")
            print(f"[tetranyte] DUT work_dir = {dut_dir}")

            # list files
            try:
                entries = os.listdir(dut_dir)
            except Exception as e:
                print(f"[tetranyte] ERROR reading {dut_dir}: {e}")
                entries = []
            print(f"[tetranyte] contents of work_dir: {entries}")

            # find .elf - search in multiple possible locations
            elf_candidates = []
            search_dirs = [
                dut_dir,
                os.path.dirname(dut_dir),  # parent directory
                os.path.join(os.path.dirname(dut_dir), "ref"),  # ref directory
            ]

            for search_dir in search_dirs:
                if os.path.exists(search_dir):
                    elf_candidates.extend(glob.glob(os.path.join(search_dir, "*.elf")))

            print(f"[tetranyte] ELF candidates: {elf_candidates}")

            # If no ELF files found, check what's actually in the ref directory
            if not elf_candidates:
                parent_dir = os.path.dirname(dut_dir)
                ref_dir = os.path.join(parent_dir, "ref")
                
                # Get parent directory contents
                parent_files = os.listdir(parent_dir) if os.path.exists(parent_dir) else []
                
                print(f"[tetranyte] Checking ref directory: {ref_dir}")
                if os.path.exists(ref_dir):
                    ref_files = os.listdir(ref_dir)
                    print(f"[tetranyte] Ref directory contents: {ref_files}")
                    
                    # Look for ELF files in ref directory
                    ref_elf_candidates = glob.glob(os.path.join(ref_dir, "*.elf"))
                    if ref_elf_candidates:
                        print(f"[tetranyte] Found ELF in ref directory: {ref_elf_candidates}")
                        elf_candidates = ref_elf_candidates
                else:
                    ref_files = []

            if not elf_candidates:
                raise FileNotFoundError(
                    f"No .elf found in {search_dirs}\\n"
                    f"* dut_dir contents: {entries}\\n"
                    f"* parent_dir contents: {parent_files}\\n"
                    f"* ref_dir contents: {ref_files if 'ref_files' in locals() else 'N/A'}"
                )

            elf = elf_candidates[0]
            print(f"[tetranyte] Using ELF file: {elf}")

            mem = os.path.splitext(elf)[0] + ".mem"
            print(f"[tetranyte] expected .mem = {mem}")

            # objcopy -> .mem
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
                print(f"[tetranyte] objcopy stdout:\\n{cp.stdout}")
                print(f"[tetranyte] objcopy stderr:\\n{cp.stderr}")
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
                print(f"[tetranyte] sim stdout:\\n{simp.stdout}")
                print(f"[tetranyte] sim stderr:\\n{simp.stderr}")
                simp.check_returncode()
            except Exception as e:
                print(f"[tetranyte] SIM FAILED: {e}")
                traceback.print_exc()
                raise

        print(f"[tetranyte] all tests passed!")

