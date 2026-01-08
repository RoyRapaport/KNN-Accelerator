# Project Documentation & Presentations

This directory contains the comprehensive documentation and official presentations for the KNN Classifier Accelerator project. These files cover the entire design cycle, from initial algorithm selection to final physical sign-off.

## 📄 Key Documents

### 1. KNN Classifier - Final Technical Report
A detailed 75-page technical document covering every phase of the project:
* **Theoretical Background**: Analysis of the KNN algorithm, K-selection (K=5), and distance metrics (Manhattan vs. Euclidean).
* **Architecture Design**: Deep dive into the four parallel distance units, the shift-register memory logic, and the custom 9-number Bitonic Sort.
* **Backend Flow**: Documentation of the TSMC 65nm synthesis, Floorplanning, CTS, and Power Analysis.
* **Verification**: Summary of VCS simulations, Gate-Level Simulations (GLS), and formal LEC checks.

## 📊 Presentations

### 2. Frontend Design Presentation
This presentation focuses on the logical implementation and architectural trade-offs:
* **Software Reference**: Python implementation results used as a golden model.
* **RTL Architecture**: Detailed block diagrams of the FSM and processing units.
* **Logic Verification**: Functional simulation results and SystemVerilog assertions (SVA).

### 3. Backend Design Presentation
This presentation covers the physical implementation and manufacturing preparation:
* **Synthesis & LEC**: Transitioning from RTL to gate-level netlist and ensuring logical equivalence.
* **Physical Implementation**: Insights into Floorplanning, Placement density (0.35), and Routing.
* **Sign-off Analysis**: Static and Dynamic power results, IR drop heatmaps, and Timing closure (9.885 ns critical path).

---

## 🛠 Tools Used for Documentation
* **Microsoft Word & Visio**: Technical writing and architectural schematics.
* **Cadence & Synopsys Platforms**: Data extraction for backend and verification reports.
