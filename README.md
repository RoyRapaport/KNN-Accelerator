# KNN-Accelerator
The KNN classifier accelerator leverages parallel processing and a custom hardware architecture to enhance the performance of the KNN algorithm. Our work involved software implementation, architectural and logic design, the verification and simulation of the system.

# KNN Classifier Hardware Accelerator

This repository contains the complete design and implementation of a high-performance hardware accelerator for the **K-Nearest Neighbors (KNN)** algorithm. The project was developed at the **Technion - Israel Institute of Technology** (Faculty of Electrical & Computer Engineering) in collaboration with **Apple Israel**.

## 📌 Project Overview
The accelerator is designed to classify data points based on their K-closest neighbors in a high-dimensional space. Our implementation focuses on performance efficiency, maximizing classification speed while minimizing power consumption, area, and hardware resources.

### Key Technical Specifications
* **Technology:** TSMC 65nm CMOS process.
* **Target Frequency:** 100 MHz (10ns clock period).
* **Algorithm Parameters:** K=5, utilizing 2 labeled groups (0, 1).
* **Distance Metric:** Manhattan Distance.
* **Dataset Capacity:** 128 labeled training points.
* **Data Precision:** 10-bit values for X and Y axes (0-1023 range).
* **Die Size:** 1000 x 1060 μm² (including bond pads).

---

## 🏗 System Architecture
The top-level architecture is partitioned into several high-performance sub-modules:

* **Parallel Distance Units:** Four independent modules calculating Manhattan distance simultaneously, reducing total latency from 128 to 32 clock cycles.
* **Optimized Bitonic Sorter:** A custom-designed sorting network optimized to identify only the 5 smallest distances, significantly reducing hardware overhead compared to a full sort.
* **Shift-Register Memory:** A cyclic memory implementation chosen for its reduced complexity in control signal management.
* **Group Decider:** A logic unit that classifies the test point based on the majority label of the 5 closest neighbors.
* **Mealy FSM Controller:** A sophisticated finite state machine overseeing data flow through Idle, Write, Transition, Sort, and Finish states.

---

## 🚀 Design Flow & Results

### 1. Frontend & Verification
* **Software Reference:** Algorithm first implemented in Python to establish a golden benchmark for hardware validation.
* **Logic Verification:** Verified using the **Synopsys VCS** platform, ensuring logical alignment with intended functionality.
* **Assertions:** Integrated SystemVerilog Assertions (SVA) to verify data integrity during memory shifts and sorting phases.
* **LEC:** Passed Logical Equivalence Checking using **Cadence Conformal** (RTL vs. Post-Synthesis Netlist).

### 2. Backend & Physical Design
* **Synthesis:** Translated RTL to gate-level netlist using **Synopsys Design Compiler**.
* **Clock Tree Synthesis (CTS):** Achieved a balanced tree with a maximum skew of **60 ps** and an insertion delay of **280 ps**.
* **Power Analysis:** Total static power of **42.95 mW** and dynamic peak current consumption of **0.122 A**.
* **IR Drop:** Voltage drop maintained well below the 7% limit (VDD IR drop: 13.28 mV).
* **Signoff:** Achieved timing closure with a critical path delay of **9.885 ns**.
* **Physical Verification:** Successfully passed 100% **LVS** and **DRC** (after dummy metal insertion).

---

## 📂 Repository Structure
* `rtl_files/`: Synthesizable Verilog source code, sub-modules, and verification environments (Testbenches).
* `visio_diagrams/`: Architectural schemes, logic phases.
* `general_files/`: Final technical report and project summary presentations.

---

## 👥 Authors
* **Roy Rapaport**
* **Dan Katz**
* **Supervised by:** Goel Samuel
