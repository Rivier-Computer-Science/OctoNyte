# riscof_plugins/dut_octonyte_verilator.py
from riscof.utils import shell
from pathlib import Path
import json, shutil

class Plugin:
    def __init__(self, isa, workdir, comp_opts):
        self.isa      = isa
        self.workdir  = Path(workdir)
        self.prefix   = comp_opts.get('prefix', 'riscv64-linux-gnu-')
        self.top      = comp_opts.get('top',   'Top')
        self.ver      = comp_opts.get('verilog', 'RTL/generated/Top.v')

    # --------------------------------------------------------------
    def compile(self, test, output):
        """Convert ELF -> Verilog hex for TertaNyte memory initialisation"""
        elf = Path(test).resolve()
        hex = Path(output)/ (elf.stem + '.hex')
        shell(f"{self.prefix}objcopy -O verilog --vmem-width 32 {elf} {hex}")
        return hex

    # --------------------------------------------------------------
    def run(self, hexfile, log, timeout=5):
        """Run Verilated core on hexfile, dump signature to <log>"""
        simdir = self.workdir/'obj_dir'
        if not simdir.exists():             # one‑time C++ build
            shell(f"verilator -cc -O3 -CFLAGS -std=c++17 "
                  f"{self.ver} sim/verilator/tb_compliance.cpp")
            shell(f"make -C {simdir} -f V{self.top}.mk V{self.top}")
        shell(f"{simdir}/V{self.top} {hexfile} > {log}")

    # --------------------------------------------------------------
    def parse_sig(self, log, sig_path):
        """RISCOF expects the signature bytes in a file named <sig_path>"""
        shutil.copyfile('rtl.sig', sig_path)   # tb writes rtl.sig
