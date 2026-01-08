# Architectural Diagrams & Design Schemes

This directory contains the high-resolution architectural diagrams for the KNN Classifier Accelerator. These schemes illustrate the logical hierarchy and data flow of the chip's modules, highlighting the design choices made to optimize for area and power.

## 🏗 System Hierarchy & Control

### 1. Top-Level Chip Architecture
* **File:** `KNN Accelerator.png`
* **Description:** A detailed schematic of the `top_chip` module. It shows the global connectivity between the I/O pads, the internal FSM controller, the processing core, and the output flip-flops ensuring all outputs come directly from registers.

### 2. Finite State Machine (FSM)
* **File:** `Controller.png`
* **Description:** The Mealy FSM logic that coordinates system tasks. The diagram illustrates the five key states: `Idle`, `Memory_write`, `Transition_st`, `Sort`, and `Knn_finished`.

---

## ⚡ Data Path & Design Trade-offs

### 3. Parallel Distance Calculators
* **File:** `Distance Calculator.png`
* **Description:** A block diagram showing the 4-way parallel implementation of the Manhattan Distance logic. It illustrates the concurrent calculation of $|x1-x2| + |y1-y2|$ to reduce system latency from 128 to 32 cycles.

### 4. Optimized Sorting Network (Bitonic Sort)
* **File:** `Bitonic Sort.png`
* **Description:** This diagram represents the heart of our classification logic. 
    * **Design Options:** During development, we evaluated three different approaches:
        1. **Pipeline Approach:** High throughput but significant area overhead.
        2. **Trivial Logic-Level Comparison:** Simpler but lacks efficiency for multiple nearest neighbors.
        3. **Bitonic Sort (Selected):** Chosen for its ideal balance of low control complexity and hardware efficiency.
    * **Implementation:** The diagram shows how this custom 9-number sorting network is optimized to identify only the 5 smallest distances (K=5) rather than performing a full sort. This optimization allowed us to use only 22 comparators and 40 MUXes, significantly reducing the chip's core area.

### 5. Memory Architecture & Shift Registers
* **File:** `Memory - option 2.png`
* **Description:** This scheme details how the 128 labeled training points are stored and managed.
    * **Design Options:** Two main architectures were considered:
        1. **Address-Based MUX (Option 1):** Traditional memory addressing, which proved to have high complexity in control and routing.
        2. **Shift Register (Option 2 - Selected):** A cyclic shift-register approach. 
    * **Implementation:** As seen in the diagram, Option 2 was selected because it simplifies the control signals needed for data movement. The architecture supports high-speed sequential writing and a unique 4-output reading mechanism that feeds the parallel distance calculators simultaneously every cycle.

### 6. Classification Logic
* **File:** `Group Decider.png`
* **Description:** Illustrates the majority-vote logic. It takes the 5 labels associated with the smallest distances and determines the final classification (`o_group`).

---

## 🎨 Design Tools
Architectural schemes were developed using **Microsoft Visio**.
