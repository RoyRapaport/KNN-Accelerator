# Architectural Diagrams & Design Schemes

This directory contains the high-resolution architectural diagrams for the KNN Classifier Accelerator, as presented in the project's Frontend Design Review. These diagrams illustrate the logical hierarchy and data flow of the chip's modules.

## 🏗 System Hierarchy & Control

### 1. Top-Level Chip Architecture
A detailed schematic of the `top_chip` module, showing the global connectivity between the I/O pads, the internal FSM controller, and the processing core. It highlights how data from 128 training points is routed through the system.

### 2. Mealy Finite State Machine (FSM)
The logical controller of the chip. The diagram shows the transitions between the five key states:
* **Idle**: Waiting for system initialization.
* **Memory Write**: Loading the 128 labeled training points into the shift registers.
* **Transition**: A critical one-cycle delay ensuring test point data is latched.
* **Sort**: The active phase where distance calculation and bitonic sorting occur.
* **KNN Finished**: Outputting the final classification result (`o_group`).

---

## ⚡ Data Path & Processing Units

### 3. Parallel Distance Calculators (x4)
A block diagram showing the 4-way parallel implementation of the Manhattan Distance logic. It illustrates how the X and Y coordinates are processed simultaneously to calculate $|x1-x2| + |y1-y2|$ across 32 cycles.

### 4. Optimized Bitonic Sorting Network
A detailed 3-phase visualization of our custom sorting logic:
* **Phase 1**: Initial pairwise comparison.
* **Phase 2**: 4-element bitonic merge.
* **Phase 3**: Extraction of the 5 smallest values.
The diagram showcases the hardware efficiency achieved by using only 22 comparators and 40 MUXes to find the nearest neighbors.

### 5. Cyclic Shift-Register Memory
An architectural view of the memory module, showing the 128-register chain and the feedback loop that allows for continuous data shifting without
