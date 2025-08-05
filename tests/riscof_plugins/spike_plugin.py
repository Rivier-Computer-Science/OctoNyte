import os
import shutil
from pathlib import Path
from riscof.utils import shell

class Plugin:
    def __init__(self, isa, workdir, comp_opts):
        self.isa = isa
        self.workdir = Path(workdir)
        self.prefix = comp_opts.get('prefix', 'riscv64-linux-gnu-')

    def compile(self, test, output):
        """Compile test for Spike"""
        elf = Path(test).resolve()
        compiled_elf = Path(output) / (elf.stem + '.elf')
        # Copy the already compiled ELF
        shutil.copy2(elf, compiled_elf)
        return compiled_elf

    def run(self, elf, log, timeout=60):
        """Run test on Spike"""
        cmd = f"spike --isa=RV32I pk {elf}"
        shell(cmd, log=log, timeout=timeout)

    def parse_sig(self, log, sig_path):
        """Extract signature from Spike log"""
        # Spike writes signature to begin_signature/end_signature markers
        with open(log, 'r') as f:
            content = f.read()
        
        # Extract signature section (this is a simplified version)
        # You may need to adjust this based on actual Spike output format
        sig_start = content.find('begin_signature')
        sig_end = content.find('end_signature')
        
        if sig_start != -1 and sig_end != -1:
            signature = content[sig_start:sig_end]
            with open(sig_path, 'w') as f:
                f.write(signature)
        else:
            # Create empty signature file if markers not found
            Path(sig_path).touch()
