# **Data Collected by UAV**

![UAV_fork](C:\Users\94198\Desktop\README_v6\img\forking_road\UAV_fork.png)

## Description 

The scenario contains 9 roadside facilities (RSFs) and a fork in the road. The UAV is equipped with communication devices and multi-modal sensors, including three cameras, two types of depth cameras (three each), and a LiDAR. The time interval between adjacent snapshots is 50 ms and the frame rate of the multi-modal sensory data at the UAV is 20 Hz. The frame rate of the communication data is also 20 Hz. The snapshots corresponding to all data are reflected in the filenames, such as "snapshot91_pointcloud.txt" for LiDAR point cloud data at snapshot 91 and "csi_95.mat" for the chanenl matrix at snapshot 95. The total duration of all three scenarios is 75 s with snapshots ranging from 1 to 1500.
Special case: in the txt files, we set the Z-values of all ground vehicular trajectories to 0.
 
## Coordinate System Description

### **[World Coordinate System]:**
The world coordinate system is a North-East-Down (NED) coordinate system with the X-axis pointing north, the Y-axis pointing east, and the Z-axis pointing downward. It is a right-handed coordinate system, with the origin at the same height as the ground.

### **[Vehicle Coordinate System]:**
This system includes both vehicles and UAVs. The X-axis points forward, the Y-axis points to the right, and the Z-axis points downward relative to the vehicle. It is a right-handed coordinate system, with the origin at the center of the vehicle and a certain height relative to the ground.

The position coordinates and heading angles given in the vehicle and UAV trajectory txt files represent the position of the vehicle coordinate system's origin in the world coordinate system, as well as the orientation of the vehicle coordinate system relative to the world coordinate system. 
(Special case: in the txt files, we set the Z-values of all ground vehicles' trajectories to 0. Before use, it is necessary to subtract the height of the vehicle center relative to the ground to obtain the actual coordinates of the vehicle coordinate system's origin in the world coordinate system.) Additionally, note that pitch, roll, and yaw in the vehicle and UAV trajectory txt files are given in radians.

### **[LiDAR Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[Camera Coordinate System]:**
The coordinate axes by default align with those of the vehicle system. If multiple cameras are mounted on a device, each camera's orientation will be specified. The camera origin is offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[mmWave Radar Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[Communication Antenna Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

## Sensor Position

The scenario includes vehicles of the **"Semi Truck"**, **"Pickup"**, **"Blue SUV"**, **"Concrete"**, **"Engineering Vehicle"**, **"Compact SUV"**, **"Sedan"**, **"Refuse Truck"**, **"Subcompact SUV"** types and **"UAV"** types. The relative coordinate positions and parameter information of the sensors are given as follows:


<table>
  <thead>
    <tr>
      <th rowspan="2">Side View</th>
      <th rowspan="2">Name</th>
      <th colspan="8" style="text-align: center;">Camera</th>
      <th colspan="5" style="text-align: center;">LiDAR</th>
      <th colspan="5" style="text-align: center;">mmWave Radar</th>
    </tr>
    <tr>
      <th>Direction</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Pitch</th>
      <th>Roll</th>
      <th>Yaw</th>
      <th>FoV Degrees(°)</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Vertical FoV(°)</th>
      <th>Horizontal FoV(°)</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Vertical FoV(°)</th>
      <th>Horizontal FoV(°)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="./img/forking_road/car1.png" alt="Side view of car1" width="100"></td>
      <td>Semi Truck</td>
      <td>+x</td>
      <td>4.5</td>
      <td>0</td>
      <td>-2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-4</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/car2.png" alt="Side view of car2" width="100"></td>
      <td>Pickup</td>
      <td>+x</td>
      <td>3.5</td>
      <td>0</td>
      <td>-1.2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-2.4</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/Car_SUV_blue.png" alt="Side view of car_SUV_blue" width="100"></td>
      <td>Blue SUV</td>
      <td>+x</td>
      <td>2</td>
      <td>0</td>
      <td>-1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-1.9</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/hunnintuche.png" alt="Side view of hunnintuche" width="100"></td>
      <td>Concrete</td>
      <td>+x</td>
      <td>1</td>
      <td>0</td>
      <td>-4.1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-4.1</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/pika.png" alt="Side view of pika" width="100"></td>
      <td>Engineering Vehicle</td>
      <td>+x</td>
      <td>2.8</td>
      <td>0</td>
      <td>-1.2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-2</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/SUV_NEW.png" alt="Side view of SUV_NEW" width="100"></td>
      <td>Compact SUV</td>
      <td>+x</td>
      <td>2.2</td>
      <td>0</td>
      <td>-1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-1.78</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/xiaochar-2.png" alt="Side view of xiaochar-2" width="100"></td>
      <td>Sedan</td>
      <td>+x</td>
      <td>2.3</td>
      <td>0</td>
      <td>-1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-1.6</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="./img/forking_road/rush.png" alt="Side view of rush" width="100"></td>
      <td>Refuse Truck</td>
      <td>+x</td>
      <td>2.5</td>
      <td>0</td>
      <td>-4.1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-4.1</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/SUV-2.png" alt="Side view of SUV-2" width="100"></td>
      <td>Subcompact SUV</td>
      <td>+x</td>
      <td>1.8</td>
      <td>0</td>
      <td>-1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
      <td>0</td>
      <td>0</td>
      <td>-1.9</td>
      <td>-25~15</td>
      <td>-180~180</td>
      <td>0</td>
      <td>0</td>
      <td>0.8</td>
      <td>-10~10</td>
      <td>-90~90</td>
    </tr>
  </tbody>
</table>


<table>
  <thead>
    <tr>
      <th rowspan="2">Side View</th>
      <th rowspan="2">Name</th>
      <th colspan="3" style="text-align: center;">Communication Equipment</th>
    </tr>
    <tr>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="./img/forking_road/car1.png" alt="Side view of car1" width="100"></td>
      <td>Semi Truck</td>
      <td>1.7</td>
      <td>0</td>
      <td>-1.7</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/car2.png" alt="Side view of car2" width="100"></td>
      <td>Pickup</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/Car_SUV_blue.png" alt="Side view of car_SUV_blue" width="100"></td>
      <td>Blue SUV</td>
      <td>0.8</td>
      <td>0</td>
      <td>-1</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/hunnintuche.png" alt="Side view of hunnintuche" width="100"></td>
      <td>Concrete</td>
      <td>0.8</td>
      <td>0</td>
      <td>-1</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/pika.png" alt="Side view of pika" width="100"></td>
      <td>Engineering Vehicle</td>
      <td>0.3</td>
      <td>0</td>
      <td>-1</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/SUV_NEW.png" alt="Side view of SUV_NEW" width="100"></td>
      <td>Compact SUV</td>
      <td>0.6</td>
      <td>-0.6</td>
      <td>-0.9</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/xiaochar-2.png" alt="Side view of xiaochar-2" width="100"></td>
      <td>Sedan</td>
      <td>0.6</td>
      <td>-0.6</td>
      <td>-1</td>
    </tr>
    <tr>
      <td><img src="./img/forking_road/rush.png" alt="Side view of rush" width="100"></td>
      <td>Refuse Truck</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
    </tr>
    <tr>
      <td><img src="img/forking_road/SUV-2.png" alt="Side view of SUV-2" width="100"></td>
      <td>Subcompact SUV</td>
      <td>0.8</td>
      <td>0</td>
      <td>-1</td>
    </tr>
  </tbody>
</table>

<table>
    <thead>
        <tr>
        <th rowspan="2">Side View</th>
        <th rowspan="2">Name</th>
        <th colspan="8" style="text-align: center;">Camera</th>
        <th colspan="5" style="text-align: center;">LiDAR</th>
        <th colspan="5" style="text-align: center;">mmWave Radar</th>
        </tr>
        <tr>
        <th>Direction</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>Pitch</th>
        <th>Roll</th>
        <th>Yaw</th>
        <th>FoV Degrees(°)</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>Vertical FoV(°)</th>
        <th>Horizontal FoV(°)</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>Vertical FoV(°)</th>
        <th>Horizontal FoV(°)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
        <td><img src="./img/drone/drone.png" alt="Side view of UAV" width="100"></td>
        <td>UAV</td>
        <td>+x</td>
        <td>4</td>
        <td>0</td>
        <td>-2</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>100</td>
        <td>0</td>
        <td>0</td>
        <td>-1.9</td>
        <td>-25~15</td>
        <td>-180~180</td>
        <td>0</td>
        <td>0</td>
        <td>0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
        </tr>
    </tbody>
</table>

<table>
    <thead>
        <tr>
        <th rowspan="2">Side View</th>
        <th rowspan="2">Name</th>
        <th colspan="3" style="text-align: center;">Communication Equipment</th>
        </tr>
        <tr>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
        <td><img src="./img/drone/drone.png" alt="Side view of UAV" width="100"></td>
        <td>UAV</td>
        <td>0</td>
        <td>0</td>
        <td>2</td>
        </tr>
    </tbody>
</table>




<table>
  <thead>
    <tr>
      <th rowspan="3">Name</th>
      <th rowspan="3">Direction</th>
      <th colspan="7" style="text-align: center;">Camera</th>
      <th colspan="5" style="text-align: center;">LiDAR</th>
      <th colspan="5" style="text-align: center;">mmWave Radar</th>
    </tr>
    <tr>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Pitch</th>
      <th>Roll</th>
      <th>Yaw</th>
      <th>FoV Degrees(°)</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Vertical FoV(°)</th>
      <th>Horizontal FoV(°)</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Vertical FoV(°)</th>
      <th>Horizontal FoV(°)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3">RSF</td> <!-- This cell now spans three rows -->
      <td>Left</td>
      <td>4.9</td>
      <td>0</td>
      <td>5.4</td>
      <td>-25</td>
      <td>0</td>
      <td>90</td>
      <td>75</td>
      <td rowspan="3">-0.2</td>
      <td rowspan="3">0</td>
      <td rowspan="3">4.3</td>
      <td rowspan="3">-40~0</td>
      <td rowspan="3">-180~180</td>
      <td rowspan="3">-0.2</td>
      <td rowspan="3">0</td>
      <td rowspan="3">0.8</td>
      <td rowspan="3">-10~10</td>
      <td rowspan="3">-90~90</td>
    </tr>
    <tr>
      <td>Middle</td>
      <td>5</td>
      <td>0</td>
      <td>5.4</td>
      <td>-25</td>
      <td>0</td>
      <td>0</td>
      <td>110</td>
    </tr>
    <tr>
      <td>Right</td>
      <td>4.8</td>
      <td>0</td>
      <td>5.4</td>
      <td>-25</td>
      <td>0</td>
      <td>-90</td>
      <td>75</td>
    </tr>
    <!-- Additional rows for other data as needed -->
  </tbody>
</table>




<table>
  <thead>
    <tr>
      <th rowspan="3">Name</th>
      <th colspan="3" style="text-align: center;">Communication Equipment</th>
    </tr>
    <tr>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="1">RSF</td> <!-- This cell now spans three rows -->
      <td>3</td>
      <td>0</td>
      <td>6</td>
    </tr>
    <!-- Additional rows for other data as needed -->
  </tbody>
</table>

**Direction:** This parameter represents the installation orientation of the sensor in the vehicle coordinate system, which can be one of the six directions: +x, -x, +y, -y, +z, -z. It describes the installation location and direction of the sensor relative to the vehicle body.

**X, Y, Z:** These three parameters collectively describe the three-dimensional spatial position of the sensor in the vehicle coordinate system, with the unit in meters. They provide the spatial coordinates of the sensor relative to the vehicle origin.

**Pitch, Roll, Yaw:** These three parameters describe the three rotational angles of the sensor in the vehicle coordinate system, with the unit in degrees. Pitch represents the pitch angle, Roll represents the roll angle, and Yaw represents the yaw angle. They define the spatial attitude of the sensor.

**Field of View(FoV) Degrees(°):** This parameter gives the total field of view angle of the sensor, with the unit in degrees. It reflects the range of the scene that the sensor can perceive.

**Vertical FoV(°):** This parameter gives the vertical field of view angle of the sensor, with the unit in degrees. It defines the sensor's perception range in the vertical direction.

**Horizontal FoV(°):** This parameter gives the horizontal field of view angle of the sensor, with the unit in degrees. It defines the sensor's perception range in the horizontal direction.


## Sensor Parameters

The camera and LiDAR sensors deployed on the vehicles in this scenario are of the same type. The specific sensor parameters are as follows:

| **Camera RGB Sensor Parameters**    | **Value** |
|-------------------------------------|-----------|
| **Width**                           | 1920      |
| **Height**                          | 1080      |
| **FOV**                             | 100。      |
| **AutoExpcosureSpeed**              | 100       |
| **AutoExposureBias**                | 0         |
| **AutoExposureMaxBrightness**       | 0.64      |
| **AutoExposureMinBrightness**       | 0.03      |
| **MotionBlurAmount**                | 0         |
| **TargetGamma**                     | 1.0       |

 | **Camera Depth Sensor Parameters** | **Value**                     |
|------------------------------------|-------------------------------|
| **Width**                          | 1920                          |
| **Height**                         | 1080                          |
| **FOV**                            | 100。                          |
| **MotionBlurAmount**               | 0                             |
| **Image Type**                     | DepthPlanner/DepthPerspective |
| **TargetGamma**                    | 1.0                           |
| **OrthoWidth**                     | 5.12                          |

| **LiDAR Sensor Parameters** |  **Value**  |
|-----------------------------|-------|
| **NumberOfChannels**        | 16    |
| **HorizontalFOVStart**      | -180  |
| **HorizontalFOVEnd**        | 180   |
| **VerticalFOVUpper**        | 15    |
| **VerticalFOVLower**        | -25   |


The camera and LiDAR sensors deployed on the UAVs in this scenario are of the same type. The specific sensor parameters are as follows:

| **Camera RGB Sensor Parameters**    | **Value** |
|-------------------------------------|-----------|
| **Width**                           | 1920      |
| **Height**                          | 1080      |
| **FOV**                             | 100。      |
| **AutoExpcosureSpeed**              | 100       |
| **AutoExposureBias**                | 0         |
| **AutoExposureMaxBrightness**       | 0.64      |
| **AutoExposureMinBrightness**       | 0.03      |
| **MotionBlurAmount**                | 0         |
| **TargetGamma**                     | 1.0       |

 | **Camera Depth Sensor Parameters** | **Value**                     |
|------------------------------------|-------------------------------|
| **Width**                          | 1920                          |
| **Height**                         | 1080                          |
| **FOV**                            | 100。                          |
| **MotionBlurAmount**               | 0                             |
| **Image Type**                     | DepthPlanner/DepthPerspective |
| **TargetGamma**                    | 1.0                           |
| **OrthoWidth**                     | 5.12                          |

| **LiDAR Sensor Parameters** | **Value** |
|-----------------------------|-----------|
| **NumberOfChannels**        | 16        |
| **HorizontalFOVStart**      | -180      |
| **HorizontalFOVEnd**        | 180       |
| **VerticalFOVUpper**        | 0         |
| **VerticalFOVLower**        | -75       |


The camera and LiDAR sensors deployed on the RSFs in this scenario are also of the same type. The specific sensor parameters are as follows:

| **Camera RGB Sensor Parameters**    | **Value** |
|-------------------------------------|-----------|
| **Width**                           | 1920      |
| **Height**                          | 1080      |
| **FOV**                             | 100。      |
| **AutoExpcosureSpeed**              | 100       |
| **AutoExposureBias**                | 0         |
| **AutoExposureMaxBrightness**       | 0.64      |
| **AutoExposureMinBrightness**       | 0.03      |
| **MotionBlurAmount**                | 0         |
| **TargetGamma**                     | 1.0       |

 | **Camera Depth Sensor Parameters** | **Value**                     |
|------------------------------------|-------------------------------|
| **Width**                          | 1920                          |
| **Height**                         | 1080                          |
| **FOV**                            | 100。                          |
| **MotionBlurAmount**               | 0                             |
| **Image Type**                     | DepthPlanner/DepthPerspective |
| **TargetGamma**                    | 1.0                           |
| **OrthoWidth**                     | 5.12                          |

| **LiDAR Sensor Parameters** | **Value** |
|-----------------------------|-----------|
| **NumberOfChannels**        | 64        |
| **HorizontalFOVStart**      | -180      |
| **HorizontalFOVEnd**        | 180       |
| **VerticalFOVUpper**        | 0         |
| **VerticalFOVLower**        | -40       |



## RSF position

The deployment of RSFs is the same across different traffic density scenarios, and the table below describes the positions of RSFs in each scenario.

<table>
  <thead>
    <tr>
      <th>ID</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
      <th>Pitch</th>
      <th>Roll</th>
      <th>Yaw</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>RSF1</td>
      <td>190</td>
      <td>-69.7</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>-25</td>
    </tr>
    <tr>
      <td>RSF2</td>
      <td>175.6</td>
      <td>-49.3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>97</td>
    </tr>
    <tr>
      <td>RSF3</td>
      <td>165.7</td>
      <td>-72.4</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>-145</td>
    </tr>
    <tr>
      <td>RSF4</td>
      <td>229.3</td>
      <td>-1.7</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>130</td>
    </tr>
    <tr>
      <td>RSF5</td>
      <td>244.3</td>
      <td>-18.2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>-50</td>
    </tr>
    <tr>
      <td>RSF6</td>
      <td>77.4</td>
      <td>-10.9</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>65</td>
    </tr>
      <td>RSF7</td>
      <td>68.3</td>
      <td>-32.6</td>
      <td>3.9</td>
      <td>0</td>
      <td>0</td>
      <td>-115</td>
    </tr>
    <tr>
      <td>RSF8</td>
      <td>201.3</td>
      <td>-163.8</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>4</td>
    </tr>
    <tr>
      <td>RSF9</td>
      <td>176.6</td>
      <td>-165.7</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>-176</td>
    </tr>
  </tbody>
</table>

**X, Y, Z:** These three parameters collectively describe the three-dimensional spatial position of the RSF in the scenario, with the unit in meters.

**Pitch, Roll, Yaw:** These three parameters describe the three rotational angles of the RSF in the scenario, with the unit in degrees. Pitch represents the pitch angle, Roll represents the roll angle, and Yaw represents the yaw angle. They define the spatial attitude of the RSF.

## Correspondence between vehicle types and Car ID under different intelligent agent densities

<table>
  <tr>
    <th rowspan="2">Type</th>
    <th colspan="3" style="text-align: center;">Car ID under different intelligent agent densities</th>
  </tr>
  <tr>
    <th>Low</th>
    <th>Medium</th>
    <th>High</th>
  </tr>
  <tr>
    <td>Semi Truck</td>
    <td>X</td>
    <td>9</td>
    <td>9</td>
  </tr>
  <tr>
    <td>Pickup</td>
    <td>X</td>
    <td>X</td>
    <td>X</td>
  </tr>
  <tr>
    <td>Blue SUV</td>
    <td>2 3</td>
    <td>2 3 11</td>
    <td>2 3 11 21 22</td>
  </tr>
  <tr>
    <td>Concrete</td>
    <td>1</td>
    <td>1 12</td>
    <td>1 12</td>
  </tr>
  <tr>
    <td>Engineering Vehicle</td>
    <td>7</td>
    <td>7 14</td>
    <td>7 14 25</td>
  </tr>
  <tr>
    <td>Compact SUV</td>
    <td>5 6 8</td>
    <td>5 6 8 15</td>
    <td>5 6 8 15 16 17 18</td>
  </tr>
  <tr>
    <td>Sedan</td>
    <td>X</td>
    <td>10</td>
    <td>10 23 24</td>
  </tr>
  <tr>
    <td>Refuse Truck</td>
    <td>X</td>
    <td>X</td>
    <td>X</td>
  </tr>
  <tr>
    <td>SUV-2</td>
    <td>4</td>
    <td>4 13</td>
    <td>4 13 19 20</td>
  </tr>
</table>
<p><strong>Note:</strong> In the table below, "X" indicates that the Type is not applicable.</p>

## Intelligent Agent Trajectory

The vehicle pose information for each frame is represented as follows:

- The first 3 columns represent the x, y, and z coordinates of the vehicle in that frame, in meters.
- The next 3 columns represent the roll, pitch, and yaw angles of the vehicle in that frame, in radians.
- The last column represents the frame number.

| Traffic Density | Folder Link                                                  |
| --------------- | ------------------------------------------------------------ |
| Low             | [Low Traffic Density Folder](link/to/low/traffic/density/folder) |
| Medium          | [Medium Traffic Density Folder](link/to/medium/traffic/density/folder) |
| High            | [High Traffic Density Folder](link/to/medium/traffic/density/folder) |

It should be noted that the frame interval of each car in the simulation scene is a subset of the 1st frame to the 1500th frame. For example, Car1 enters the scene at the 1st frame and leaves the scene at the 828th frame. The valid frame interval is from the 1st frame to the 827th frame, and the 828th frame to the 1500th frame is an invalid frame interval, which does not provide perception and communication data.
We sort out the valid simulation intervals of each car in this scene as follows.
<table>
  <tr>
    <th rowspan="2">Car id</th>
    <th colspan="2" style="text-align: center;">Sunnyday_Morning_Low intelligent agent density</th>
</tr>
  <tr>
            <th>Start Frame</th>
            <th>Stop Frame</th>
  </tr>
        <tr><td>Car5</td><td>751</td><td>1500</td></tr>
        <tr><td>UAV1</td><td>1</td><td>1500</td></tr>
</table>
<p><strong>Note:</strong> In the table below, "NaN" indicates that The vehicle is not involved in the simulation.</p>

