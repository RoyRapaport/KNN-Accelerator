# Architectural Diagrams & Design Schemes

This directory contains the high-resolution architectural diagrams for the KNN Classifier Accelerator. These schemes illustrate the logical hierarchy and data flow of the chip's modules, highlighting the design choices made to optimize for area and power.

## 🏗 System Hierarchy & Control

### 1. Top-Level Chip Architecture
* **File:** `KNN Accelerator.png`
* **Description:** A detailed schematic of the `top_chip` module. It shows the global connectivity between the I/O pads, the internal FSM controller, the processing core, and the output flip-flops ensuring all outputs come directly from registers.
[Image of the Top Level Architecture Scheme]

### 2. Finite State Machine (FSM)
* **File:** `Controller.png`
* **Description:** The Mealy FSM logic that coordinates system tasks. The diagram illustrates the five key states: `Idle`, `Memory_write`, `Transition_st`, `Sort`, and `Knn_finished`.

---

## ⚡ Data Path & Design Trade-offs

### 3. Parallel Distance Calculators
* **File:** `Distance Calculator.png`
* **Description:** A block diagram showing the 4-way parallel implementation of the Manhattan Distance logic. It illustrates the concurrent calculation of $|x1-x2| + |y1-y2|$ to reduce system latency from 128 to 32 cycles.
[Image of the Distance Calculator Unit]

### 4. Optimized Bitonic Sorting Network
* **File:** `Bitonic Sort.png`
* **Description:** **Design Options:** We evaluated three sorting implementations: a pipeline approach (Option 1), a trivial logic-level comparison (Option 2), and the Bitonic Sort (Option 3)
