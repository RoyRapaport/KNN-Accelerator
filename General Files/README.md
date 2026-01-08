# Project Documentation & Technical Reports

This directory serves as the knowledge base for the KNN Classifier Accelerator project. It contains the official documentation, architectural deep-dives, and backend sign-off reports presented to the Technion and Apple Israel.

## 📄 Final Technical Report
**File:** `KNN Classifier - Final Report.pdf`
The complete engineering document providing a comprehensive overview of the project life-cycle.
* **Theory**: Implementation of KNN with K=5, 128 training points, and Manhattan distance.
* **Hardware-Software Trade-offs**: Selection of bitonic sort and shift-register memory to optimize for area and power.
* **Sign-off**: Detailed results for Timing, Power, LVS, and DRC.

---

## 📊 Presentations

### 1. Frontend Design & Architecture
**File:** `KNN Presentation - Front-end.pptx`
Highlights the design phase and functional verification of the accelerator.
* **Architecture**: Breakdown of the 4-way parallel distance calculation and the 3-phase Bitonic Sort network.
* **Verification Logic**: Utilization of **Synopsys VCS** for simulation and **SystemVerilog Assertions (SVA)** for protocol checking.
* **Logical Equivalence**: Verification of RTL vs. Netlist using **Cadence Conformal LEC**.

### 2. Backend & Physical Implementation
**File:** `KNN Presentation - Back-end.pptx`
Focuses on the physical realization of the chip in **TSMC 65nm** technology.
* **Synthesis & Optimization**: Using **Synopsys Design Compiler** to reach a 100MHz target frequency.
* **Physical Implementation**: 
    * **Floorplan**: 48 I/O pads with optimized power ring distribution.
    * **CTS**: Balanced clock tree with **60ps skew** and **280ps insertion delay**.
    * **Utilization**: Core density set at **0.35** to mitigate IR drop and congestion.
* **Sign-off Analysis**:
    * **Timing**: Met setup/hold constraints with a **9.885ns critical path**.
    * **Power**: Static power of **42.95mW** and Dynamic Peak of **0.139W**.
    * **Integrity**: **VDD IR Drop of 13.28mV**, well within the 7% project limit.

---

## 🛠 Project Ecosystem (Toolchain)
* **Frontend**: Synopsys VCS, Cadence Conformal LEC.
* **Backend**: Synopsys Design Compiler, Cadence Innovus, Synopsys PrimeTime.
* **Validation**: Python (NumPy) for golden model generation.
