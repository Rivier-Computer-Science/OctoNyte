import os
import shutil
from pathlib import Path
from riscof.utils import shell

class Plugin:
    def __init__(self, isa, workdir, comp_opts):
        self.isa = isa
        self.workdir = Path(workdir)
        self.prefix = comp_opts.get('prefix', 'riscv64-linux-gnu-')
        self.top = comp_opts.get('top', 'Top')
        # Use absolute path for Verilog file
        self.ver = Path(comp_opts.get('verilog', '../RTL/generated/Top.v')).resolve()
        
        # Ensure workdir exists
        self.workdir.mkdir(parents=True, exist_ok=True)

    def compile(self, test, output):
        """Convert ELF -> Verilog hex for TertaNyte memory initialisation"""
        elf = Path(test).resolve()
        output_dir = Path(output)
        output_dir.mkdir(parents=True, exist_ok=True)
        hex_file = output_dir / (elf.stem + '.hex')
        
        # Convert ELF to hex format
        cmd = f"{self.prefix}objcopy -O verilog --verilog-data-width=4 {elf} {hex_file}"
        shell(cmd)
        return hex_file

    def run(self, hexfile, log, timeout=60):
        """Run Verilated core on hexfile, dump signature to <log>"""
        # Change to workdir for simulation
        original_cwd = os.getcwd()
        os.chdir(self.workdir)
        
        try:
            simdir = Path('obj_dir')
            
            # One-time C++ build if needed
            if not simdir.exists() or not (simdir / f'V{self.top}').exists():
                # Ensure the Verilog file exists
                if not self.ver.exists():
                    raise FileNotFoundError(f"Verilog file not found: {self.ver}")
                
                # Build the simulation
                tb_path = Path('../sim/verilator/tb_compliance.cpp').resolve()
                if not tb_path.exists():
                    raise FileNotFoundError(f"Testbench not found: {tb_path}")
                
                shell(f"verilator -cc -O3 --exe -CFLAGS -std=c++17 "
                      f"--build {self.ver} {tb_path} --top-module {self.top}")
            
            # Run simulation
            sim_exe = simdir / f'V{self.top}'
            if not sim_exe.exists():
                raise FileNotFoundError(f"Simulation executable not found: {sim_exe}")
            
            # Run with absolute paths
            abs_hexfile = Path(hexfile).resolve()
            abs_log = Path(log).resolve()
            
            shell(f"{sim_exe} {abs_hexfile} > {abs_log}", timeout=timeout)
            
        finally:
            os.chdir(original_cwd)

    def parse_sig(self, log, sig_path):
        """RISCOF expects the signature bytes in a file named <sig_path>"""
        # Look for signature file in workdir
        sig_file = self.workdir / 'rtl.sig'
        
        if sig_file.exists():
            shutil.copyfile(sig_file, sig_path)
        else:
            # If no signature file found, create empty one
            Path(sig_path).touch()
            print(f"Warning: No signature file found at {sig_file}")
