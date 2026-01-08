# RTL Design & Verification (SystemVerilog)

This directory contains the complete Hardware Description Language (HDL) implementation of the KNN Accelerator, including all sub-modules and their respective verification environments.

## 📁 Directory Structure

* **Modules (`*.sv` / `*.v`):** Synthesizable logic for the KNN core.
* **Testbenches (`*_tb.sv`):** Unit and system-level verification environments.

---

## 🏗 Core Modules Breakdown

### 1. Data Management & Memory
* **`memory.sv`**: Implements a cyclic 128-entry shift register for labeled training points. Choice of shift-register architecture over address-based MUX significantly reduced control signal complexity.
* **`test_point_reg.sv`**: Dedicated registers for latching the unlabeled test point coordinates.

### 2. Computation Engines
* **`distance_calc.sv`**: Implements parallel Manhattan Distance logic. Subtracts coordinates and sums absolute differences while preserving the labeled group bit (MSB).
* **`bitonic_sort.sv`**: A custom, area-optimized 9-number sorting network. Modified to extract only the 5 nearest neighbors to save hardware resources (utilizing 22 comparators and 40 MUXes).

### 3. Control & Decision Logic
* **`controller_fsm.sv`**: A Mealy state machine managing the operation flow. Includes a specialized `transition_st` to ensure valid data latching before computation.
* **`group_decider.sv`**: Implements majority-vote logic based on the 5 smallest distances to determine the final classification.

---

## ✅ Verification & Testbenches

The verification strategy focused on modular and systemic reliability:

### Unit Testbenches
Each module includes a dedicated testbench (e.g., `distance_calc_tb.sv`, `bitonic_sort_tb.sv`) to verify:
* **Memory Integrity**: Correct data shifting during Write/Read phases.
* **Sorting Accuracy**: Verification of "Smallest-5" extraction across random distance vectors.
* **Distance Logic**: Correct handling of both positive and negative coordinate differences.

### System-Level Verification (`top_chip_tb.sv`)
* **End-to-End Classification**: Simulates multiple full KNN cycles, providing new training/test points and verifying the `o_group` output against Python golden vectors.
* **System Assertions (SVA)**: Integrated checks to monitor `o_busy` status and FSM state transitions during simulation.

---

## 🛠 Simulation Flow
1. **Compilation**: Compile all
