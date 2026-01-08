# Visual Architecture & Physical Layout Gallery

This directory contains the high-resolution architectural diagrams and backend layout visualizations for the KNN Classifier Accelerator. These visuals represent the design evolution from logical block diagrams to the final 65nm silicon layout.

## 📐 Logical & Architectural Diagrams

### 1. Top-Level Architecture
Detailed schematic showing the global connectivity between the FSM Controller, Parallel Distance Calculation Units, and the Bitonic Sorting Network.
[Image of the Top Level Block Diagram of the KNN Classifier]

### 2. Custom Bitonic Sort Phases
A comprehensive breakdown of our optimized sorting network, illustrating Phase 1 (Pairwise Comparison), Phase 2 (4-Element Merge), and Phase 3 (Smallest-5 Extraction).
[Image of the custom 9-number Bitonic Sort phases]

### 3. FSM State Transitions
The Finite State Machine (Mealy) logic, showcasing the conditions for transitions between `Idle`, `Memory_write`, `Transition_st`, `Sort`, and `Knn_finished`.

---

## 🏗 Backend & Physical Design (Signoff)

### 4. Floorplan & Power Grid
Visualization of the die area ($1000 \times 1060 \mu m^2$), featuring the VDD/VSS Power Rings and the strategic placement of 48 I/O pads.
