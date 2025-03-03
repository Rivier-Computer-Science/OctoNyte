import os
import subprocess
import difflib

# Paths to required tools
SPIKE_PATH = "/usr/local/bin/spike"
VERILATOR_SIM_PATH = "./simv" 
TEST_BINARIES_DIR = "./test_binaries"
LOG_DIR = "./logs"
CYCLE_LOG_DIR = "./cycle_logs"

# Ensure log directories exist
os.makedirs(LOG_DIR, exist_ok=True)
os.makedirs(CYCLE_LOG_DIR, exist_ok=True)

def run_spike(binary):
    """Run Spike simulator with a given RISC-V binary and capture output including cycle counts."""
    spike_log = os.path.join(LOG_DIR, f"{binary}_spike.log")
    spike_cycle_log = os.path.join(CYCLE_LOG_DIR, f"{binary}_spike_cycles.log")
    command = f"{SPIKE_PATH} --isa=rv64gc --log-commits {os.path.join(TEST_BINARIES_DIR, binary)} > {spike_log} 2>&1"
    subprocess.run(command, shell=True, check=True)

    # Extract cycle count information from Spike logs
    extract_cycle_counts(spike_log, spike_cycle_log)
    return spike_log, spike_cycle_log

def run_verilator(binary):
    """Run Verilator RTL simulation with a given binary and capture output including cycle counts."""
    verilator_log = os.path.join(LOG_DIR, f"{binary}_verilator.log")
    verilator_cycle_log = os.path.join(CYCLE_LOG_DIR, f"{binary}_verilator_cycles.log")
    command = f"{VERILATOR_SIM_PATH} {os.path.join(TEST_BINARIES_DIR, binary)} > {verilator_log} 2>&1"
    subprocess.run(command, shell=True, check=True)

    # Extract cycle count information from Verilator logs
    extract_cycle_counts(verilator_log, verilator_cycle_log)
    return verilator_log, verilator_cycle_log

def extract_cycle_counts(input_log, output_log):
    """Extract cycle count information from log files and save to a separate file."""
    with open(input_log, "r") as infile, open(output_log, "w") as outfile:
        for line in infile:
            if "cycle" in line.lower():  # Adjust based on log format
                outfile.write(line)

def compare_logs(spike_log, verilator_log):
    """Compare execution logs from Spike and Verilator."""
    with open(spike_log, "r") as f1, open(verilator_log, "r") as f2:
        spike_output = f1.readlines()
        verilator_output = f2.readlines()

    diff = list(difflib.unified_diff(spike_output, verilator_output, lineterm=""))
    if diff:
        print(f"❌ Mismatch detected in {spike_log} vs {verilator_log}!")
        for line in diff[:10]:  # Show only first 10 differences
            print(line)
    else:
        print(f"✅ Logs match for {spike_log} and {verilator_log}.")

def compare_cycles(spike_cycle_log, verilator_cycle_log):
    """Compare cycle execution counts between Spike and Verilator."""
    with open(spike_cycle_log, "r") as f1, open(verilator_cycle_log, "r") as f2:
        spike_cycles = f1.readlines()
        verilator_cycles = f2.readlines()

    diff = list(difflib.unified_diff(spike_cycles, verilator_cycles, lineterm=""))
    if diff:
        print(f"❌ Cycle mismatch detected in {spike_cycle_log} vs {verilator_cycle_log}!")
        for line in diff[:10]:  # Show only first 10 differences
            print(line)
    else:
        print(f"✅ Cycle counts match for {spike_cycle_log} and {verilator_cycle_log}.")

def run_tests():
    """Run all test binaries through both simulators and compare results."""
    for binary in os.listdir(TEST_BINARIES_DIR):
        if binary.endswith(".elf"):  # Ensure we only process binaries
            print(f"\n🔍 Testing {binary}...")
            spike_log, spike_cycle_log = run_spike(binary)
            verilator_log, verilator_cycle_log = run_verilator(binary)

            compare_logs(spike_log, verilator_log)
            compare_cycles(spike_cycle_log, verilator_cycle_log)

if __name__ == "__main__":
    run_tests()
