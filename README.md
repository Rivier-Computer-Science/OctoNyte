# OctoNyte
A RISC-V Multithreaded Core Targeting the Skywater 0.13um ASIC library
**Story**  
As a **RISC-V Simulation Engineer**, I want to **co-simulate RTL implementations** alongside **Spike** (the official RISC-V ISA simulator) so that I can confirm functional correctness, detect potential mismatches between the hardware design and the reference model, and optimize performance and design parameters before final tape-out.


### **Acceptance Criteria**

1. **Spike & RTL Co-Simulation Setup**  
   - **Condition:** There must be a framework that allows cycle-by-cycle or transaction-level comparison between the RTL signals and Spike’s reference state (registers, memory).  
   - **Test:** Running a set of instructions or a full program in the co-simulation environment should produce matching results between RTL and Spike at all relevant checkpoints.  
   - **Satisfaction:** No mismatches occur for validated instructions and memory transactions under normal operating conditions.

2. **ISA Compliance & Extensions**  
   - **Condition:** Co-simulation must handle various RISC-V ISA extensions (M, A, F, D, etc.) consistently.  
   - **Test:** The system runs the official RISC-V compliance suite in co-simulation mode, checking that each instruction in the extended sets behaves identically in both the RTL and Spike.  
   - **Satisfaction:** All compliance tests pass (or mismatches are flagged and diagnosed).

3. **Scalability & Performance**  
   - **Condition:** The co-simulation environment should handle larger test programs (e.g., Linux boot, SPEC benchmarks) without prohibitive runtime.  
   - **Test:** Testing a moderately sized benchmark (e.g., CoreMark or a basic Linux environment) completes in under a target timeframe (e.g., 2 hours).  
   - **Satisfaction:** Simulation performance is acceptable for iterative development, and major performance bottlenecks are documented or mitigated.

4. **Analysis & Reporting**  
   - **Condition:** The environment must generate detailed logs and summaries for debug and performance analysis.  
   - **Test:** When mismatches occur (e.g., register states differ), the system logs the offending instruction and context (PC, register values, time).  
   - **Satisfaction:** Engineers can quickly locate and diagnose the source of mismatches or performance anomalies; logs are exportable (JSON, CSV) for deeper analysis.

5. **Validation & Accuracy**  
   - **Condition:** Co-simulation results must be validated against known hardware data or performance metrics.  
   - **Test:** Compare the final architectural state (register contents, memory values) and cycle counts (if feasible) against real hardware or established reference data.  
   - **Satisfaction:** Results match or deviate within an acceptable threshold (e.g., <1% for performance counters).

6. **User Feedback & Parameter Changes**  
   - **Condition:** Engineers should easily enable or disable RISC-V extensions, alter memory configurations, or modify design features in the RTL or Spike.  
   - **Test:** Changing a parameter (e.g., memory size, adding the “M” extension) should not break the co-simulation setup; both models reflect the new parameters seamlessly.  
   - **Satisfaction:** Configuration changes propagate smoothly with minimal manual intervention, and re-simulations run without major disruptions.

---

### **Definition of Done**

1. **Functional Requirements**  
   - Accurate RISC-V co-simulation at both the instruction and transactional levels.  
   - Ability to run official compliance tests and custom test suites for extended instructions.  
   - Automatic detection of state mismatches between the RTL and Spike.

2. **Non-Functional Requirements**  
   - Co-simulation remains performant enough for iterative regression testing (e.g., overnight runs for moderate test suites).  
   - Secure handling of design files, ensuring no data corruption or unauthorized access to proprietary RTL code.

3. **Testing & Validation**  
   - The RISC-V compliance suite passes for each targeted extension in co-simulation mode.  
   - Reference benchmarks confirm the correctness and performance alignment of the RTL design with Spike.  
   - Mismatch logs are automatically generated with sufficient detail for swift debug.

4. **Documentation**  
   - Comprehensive user guides explain how to configure, run, and troubleshoot co-simulation scenarios.  
   - Clear instructions on analyzing logs, stepping through mismatches, and extending the environment for custom instructions.

---

## **Top-Level Tasks (GitHub Sub-Issues) with Estimated Person Hours**

Below is a checklist of the primary tasks required to implement this co-simulation environment. Each task can be converted into a GitHub sub-issue; subtasks may be detailed therein as needed.

- [ ] **Task 1: Spike & RTL Integration Framework (12 ph)**  
  Establish the basic infrastructure for co-simulation. This includes hooking the RTL simulator (e.g., Verilator, VCS) to Spike’s reference model, synchronizing execution steps, and configuring data exchange.

- [ ] **Task 2: ISA Compliance & Test Suite Integration (10 ph)**  
  Incorporate official RISC-V compliance tests into co-simulation runs. Validate each instruction category (RV32I, RV64I, M, A, F, D, etc.) against the corresponding RTL logic.

- [ ] **Task 3: Parameterized Configuration (8 ph)**  
  Implement a mechanism for enabling or disabling RISC-V extensions, adjusting memory configurations, or specifying custom instructions across both Spike and the RTL environment.

- [ ] **Task 4: Performance & Scalability Testing (12 ph)**  
  Test co-simulation with larger workloads (e.g., Linux boot, SPEC CPU or CoreMark). Measure runtime, identify bottlenecks, and optimize the environment for feasible iteration cycles.

- [ ] **Task 5: Mismatch Detection & Logging (10 ph)**  
  Develop logging and comparison modules to detect register or memory state mismatches. Generate actionable reports specifying the exact instruction and cycle of divergence.

- [ ] **Task 6: Validation Against Hardware/Reference Data (10 ph)**  
  Compare co-simulation results with known hardware traces (where available) or established performance metrics. Verify correctness and fine-tune the environment for minimal deviation.

- [ ] **Task 7: Reporting & Analysis Tools (8 ph)**  
  Create or integrate tools that parse co-simulation logs to produce summary dashboards, highlighting coverage gaps, mismatch frequency, or performance hotspots.

- [ ] **Task 8: Documentation & Best Practices (6 ph)**  
  Produce a comprehensive manual detailing setup steps, configuration variables, debug workflows, and advanced usage scenarios. Include troubleshooting tips and known limitations.


