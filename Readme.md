# **Overview**

Given the importance of datasets for sensing-communication integration research, a novel simulation platform for constructing
communication and multi-modal sensory dataset is developed. The developed platform integrates three high-precision software,
i.e., AirSim, WaveFarer, and Wireless InSite, and further achieves in-depth integration and precise alignment of them. Based
on the developed platform, a new synthetic intelligent multi-modal sensing-communication integration dataset for Synesthesia
of Machines (SoM), named SynthSoM, is proposed. The SynthSoM dataset contains various air-ground multi-link cooperative
scenarios with comprehensive conditions, including multiple weather conditions, times of the day, intelligent agent densities,
frequency bands, and antenna types. The SynthSoM dataset encompasses multiple data modalities, including radio-frequency
(RF) channel large-scale and small-scale fading data, RF millimeter wave (mmWave) radar sensory data, and non-RF sensory
data, e.g., RGB images, depth maps, and light detection and ranging (LiDAR) point clouds. The quality of SynthSoM dataset
is validated via statistics-based qualitative inspection and evaluation metrics through machine learning (ML) via real-world
measurements. The SynthSoM dataset is open-sourced and provides consistent data for cross-comparing SoM-related
algorithms.

![Overview](./img/Overview.png)

**Figure 1**. Framework of constructing the developed simulation platform for the generation of the SynthSoM dataset.

## **Installation**

### **Software 1: AirSim**

●  **Install Visual Studio 2022 and Unreal Engine 4.27**


​	○ **Download and install Visual Studio 2022**

​	During installation, make sure to select the individual components `.NET Framework 4.6.1 SDK` and `.NET Framework 4.6.1 targeting pack`.

​	○ **Download and install Epic Games Launcher from the [Epic Games website](https://www.unrealengine.com/download), select and install Unreal Engine version 4.27.2.**

●  **Install AirSim and set up the Python environment**


​	○ **Download AirSim**

​	Clone the AirSim repository from GitHub:

​	```sh

​	git clone https://github.com/microsoft/AirSim.git

​	cd AirSim

​	\```

​	○ **Build AirSim**

​	Run the setup script:

​	```sh

​	./setup.sh

​	```

​	Build the AirSim project:

​	```sh

​	./build.sh

​	```

​	○ **Set up Python environment**

​	Create a virtual environment with Python 3.7 and install the necessary packages

​	```sh

​	conda create -n airsim python=3.7

​	conda activate airsim

​	pip install numpy

​	pip install airsim

​	```

​	○ **Verify the installation**

​	Check for an `AirSim` folder in the `Documents` directory containing a `settings.json` file.

●  **Configure Unreal Engine for AirSim**

​	○ Open Unreal Engine and create a new project.

​	○ Follow the instructions provided in the [AirSim documentation] (https://github.com/microsoft/AirSim/blob/master/docs/unreal_custenv.md) to set up and verify a custom environment in Unreal Engine.



### **Software 2: WaveFarer**

●  **Install WaveFarer** **2.1.0.6**

Download the installation package from https://support.remcom.com/wavefarer.html, then unzip and install.

●  **Configure license**

Place the license in a folder without Chinese characters in the path, then run Wireless InSite and select that path.

●  **Install the "Create Linear Chirp Simulation" script**

Download the scripts "Create Linear Chirp Simulation.xmacro" from https://support.remcom.com/wavefarer/scripts/create-linear-chirp-simulation.html, then put it at the Macros folder, which you set at "Application Preferences" in WaveFarer. The Windows default location is C:\Users\{user-name}\Documents\Remcom\WaveFarer\scripts \menu\macros.

●  **Install the MATLAB runtime**

Download the MATLAB Runtime installation package from https://support.remcom.com/wavefarer/scripts/generate-range-doppler.html, then unzip and install.

●  **Install the "Generate Range-Doppler" script**

Download the "generate-range-doppler.zip" script package from "https://support.remcom.com/wavefarer/scripts/generate-range-doppler.html". Then unzip the folder to the same Macros folder as which in step 4.



### **Software 3: Wireless InSite**

●  **Install Wireless InSite 3.4.4 or 3.3.5**

Download the installation package from https://www.renkangtech.com/wirelessinsitexzzq, then unzip and install.

●  **Configure license**

Place the license in a folder without Chinese characters in the path, then run Wireless InSite and select that path.



## **Data Modality**

The SynthSoM dataset contains radio-frequency (RF) communication information, i.e., path loss and channel matrices, RF sensing information, i.e., mmWave radar waveforms and point clouds, and non-RF sensing information, i.e., RGB images, depth maps, and LiDAR point clouds, as listed in Table 1.

| **Communication** | **RF sensing**           | **Non-RF sensing**  |
| ----------------- | ------------------------ | ------------------- |
| Path loss         | mmWave radar waveform    | RGB image/Depth map |
| Channel matrix    | mmWave radar point cloud | LiDAR point cloud   |

**Table 1**. Data modality in the SynthSoM dataset.

 

## **Scenario**

The SynthSoM dataset contains various air-ground multi-link cooperative
scenarios, including urban crossroad, urban wide lane, urban overpass, suburban fork, and mountain road, as shown in Figs. 2-6.


### [**Scenario 1:** **Air-ground multi-link cooperative urban crossroad**](./urban_crossroad/README.md)

![urban crossroad](img/urban_crossroad.png)

**Figure 2**. Air-ground multi-link cooperative urban crossroad scenario.

### [**Scenario** **2:** **Air-ground multi-link cooperative urban wide lane**](./urban_widelane/README.md)

![urban wide lane](img/urban_widelane.png)

**Figure 3**. Air-ground multi-link cooperative urban wide lane scenario. 

### [**Scenario 3:** **Air-ground multi-link cooperative urban overpass**](./urban_overpass/README.md)

![overpass](img/overpass.png)

**Figure 4**. Air-ground multi-link cooperative urban overpass scenario. 

### [**Scenario 4:** **Air-ground multi-link cooperative suburban fork**](./forking_road/README.md)

![overpass](img/suburban_fork.png)

**Figure 5**. Air-ground multi-link cooperative suburban fork scenario. 

### [**Scenario 5:** **Air-ground multi-link cooperative mountain road**](./mountain_road/README.md)

![mountain road](img/mountain_road.png)

**Figure 6**. Air-ground multi-link cooperative mountain road scenario. 



## **Scenario Condition**

The SynthSoM dataset contains comprehensive scenario conditions, including multiple weather conditions, times of the day, intelligent agent densities, frequency bands, and antenna types, as shown in Table 2 and Fig. 7.

| **Weather** | **Time of the day** | **Intelligent agent density** | **Frequency band** | **Antenna type** |
| :---------: | :-----------------: | :---------------------------: | :----------------: | :--------------: |
|  Sunny day  |       Morning       |             High              |     Sub-6 GHz      |       SISO       |
|  Rainy day  |        Night        |            Medium             |       mmWave       |       MIMO       |
|  Snowy day  |                     |              Low              |                    |   Massive MIMO   |

**Table 2**. Comprehensive scenario conditions in the SynthSoM dataset.
![condition](./img/condition.png)
**Figure 7**. Comprehensive conditions in the SynthSoM dataset taking the urban wide lane scenario as an example.

## **Data Directory Hierarchy and Content**

The data directory hierarchy and content of the SynthSoM dataset are shown in Fig. 8

![Data Directory Hierarchy](./img/Data_Directory_Hierarchy.png)

**Figure 8**. The data directory hierarchy and content of the SynthSoM dataset.

To utilize the SynthSoM dataset for communication and multi-modal sensing tasks, we divide the SynthSoM dataset into five folders according to different scenarios. The scenario folder contains different conditions, and further contains different data modalities, i.e., RF sensory data, non-RF sensory data, and RF communication data. For convenience, the SynthSoM dataset is fully open-sourced.
