# Data Collected by UAV
<img src="./img/wide_road/UAV_urban_wide_lane.png" alt="Description of your image" width="500" height="">

## Description

The scenario contains 12 roadside facilities (RSFs) and many urban tall buildings, which can be scanned by the UAV. The UAV is equipped with communication devices and multi-modal sensors, including three cameras, two types of depth cameras (three each), and a LiDAR. The time interval between adjacent snapshots is 50 ms and the frame rate of the multi-modal sensory data at the UAV is 20 Hz. The frame rate of the communication data is also 20 Hz. The snapshots corresponding to all data are reflected in the filenames, such as "snapshot91_pointcloud.txt" for LiDAR point cloud data at snapshot 91 and "csi_95.mat" for the chanenl matrix at snapshot 95. The total duration of all three scenarios is 75 s with snapshots ranging from 1 to 1500.
Special case: in the txt files, we set the Z-values of all ground vehicular trajectories to 0.
 
## Coordinate System Description

### **[World Coordinate System]:**
The world coordinate system is a North-East-Down (NED) coordinate system with the X-axis pointing north, the Y-axis pointing east, and the Z-axis pointing downward. It is a right-handed coordinate system, with the origin at the same height as the ground.

### **[Vehicle Coordinate System]:**
This system includes both vehicles and drones. The X-axis points forward, the Y-axis points to the right, and the Z-axis points downward relative to the vehicle. It is a right-handed coordinate system, with the origin at the center of the vehicle and a certain height relative to the ground.

The position coordinates and heading angles given in the vehicle and drone trajectory txt files represent the position of the vehicle coordinate system's origin in the world coordinate system, as well as the orientation of the vehicle coordinate system relative to the world coordinate system. 
(Special case: in the txt files, we set the z-values of all ground vehicles' trajectories to 0. Before use, it is necessary to subtract the height of the vehicle center relative to the ground to obtain the actual coordinates of the vehicle coordinate system's origin in the world coordinate system.) Additionally, note that pitch, roll, and yaw in the vehicle and drone trajectory txt files are given in radians.

### **[LiDAR Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[Camera Coordinate System]:**
The coordinate axes by default align with those of the vehicle system. If multiple cameras are mounted on a device, each camera's orientation will be specified. The camera origin is offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[mmWave Radar Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

### **[Communication Antenna Coordinate System]:**
The coordinate axes align with those of the vehicle system, with the origin offset by a fixed amount relative to the vehicle coordinate system's origin.

## Sensor Position

The vehicular urban wide lane scenario includes vehicles of the **"Blue SUV"**, **"Mini Cooper"**, **"Sedan"**, **"Pickup"**, **"Box truck"**, **"Concrete"**, **"Refuse truck"**, **"School bus"**, **"Tank"** types and **"UAV"** types. The relative coordinate positions and parameter information of the sensors are given as follows:

<!-- 车端感知设备位置 -->

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
        <td><img src="./img/wide_road/car1_blue_SUV.png" alt="Side view of car1" width="100"></td>
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
        <td><img src="./img/wide_road/car2_mini_white_car_SUV.png" alt="Side view of car1" width="100"></td>
        <td>Mini Cooper</td>
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
        <td>-1.8</td>
        <td>-25~15</td>
        <td>-180~180</td>
        <td>0</td>
        <td>0</td>
        <td>0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car3_white_car.png" alt="Side view of car1" width="100"></td>
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
        <td><img src="./img/wide_road/car4_pika.png" alt="Side view of car1" width="100"></td>
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
        <td><img src="./img/wide_road/car5_xianxing_car.png" alt="Side view of car1" width="100"></td>
        <td>Box truck</td>
        <td>+x</td>
        <td>3.2</td>
        <td>0</td>
        <td>-1.4</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>100</td>
        <td>0</td>
        <td>0</td>
        <td>-2.8</td>
        <td>-25~15</td>
        <td>-180~180</td>
        <td>0</td>
        <td>0</td>
        <td>0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car6_hu_ni_tu_car.png" alt="Side view of car1" width="100"></td>
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
        <td><img src="./img/wide_road/car7_rush_car.png" alt="Side view of car1" width="100"></td>
        <td>Refuse truck</td>
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
        <td><img src="./img/wide_road/car8_school_lolar_car.png" alt="Side view of car1" width="100"></td>
        <td>School bus</td>
        <td>+x</td>
        <td>1.2</td>
        <td>0</td>
        <td>-2.8</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>100</td>
        <td>0</td>
        <td>0</td>
        <td>-2.8</td>
        <td>-25~15</td>
        <td>-180~180</td>
        <td>0</td>
        <td>0</td>
        <td>0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car9_statci_mesh .png" alt="Side view of car1" width="100"></td>
        <td>Tank</td>
        <td>+x</td>
        <td>0</td>
        <td>0</td>
        <td>-4</td>
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
    </tbody>
</table>
<!-- 车端通信设备位置 -->

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
        <td><img src="./img/wide_road/car1_blue_SUV.png" alt="Side view of car1" width="100"></td>
        <td>Blue SUV</td>
        <td>0.3</td>
        <td>0</td>
        <td>-1.1</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car2_mini_white_car_SUV.png" alt="Side view of car1" width="100"></td>
        <td>Mini Cooper</td>
        <td>0.5</td>
        <td>-0.1</td>
        <td>-1.3</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car3_white_car.png" alt="Side view of car1" width="100"></td>
        <td>Sedan</td>
        <td>0.3</td>
        <td>0</td>
        <td>-1.7</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car4_pika.png" alt="Side view of car1" width="100"></td>
        <td>Pickup</td>
        <td>3.5</td>
        <td>0</td>
        <td>1.2</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car5_xianxing_car.png" alt="Side view of car1" width="100"></td>
        <td>Box truck</td>
        <td>0</td>
        <td>0</td>
        <td>-2.1</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car6_hu_ni_tu_car.png" alt="Side view of car1" width="100"></td>
        <td>Concrete</td>
        <td>0.5</td>
        <td>-0.1</td>
        <td>-1.3</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car7_rush_car.png" alt="Side view of car1" width="100"></td>
        <td>Refuse truck</td>
        <td>0.8</td>
        <td>0</td>
        <td>-2.6</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car8_school_lolar_car.png" alt="Side view of car1" width="100"></td>
        <td>School bus</td>
        <td>0.3</td>
        <td>-0.3</td>
        <td>-1.7</td>
        </tr>
        <tr>
        <td><img src="./img/wide_road/car9_statci_mesh .png" alt="Side view of car1" width="100"></td>
        <td>Tank</td>
        <td>1.3</td>
        <td>0</td>
        <td>-1.4</td>
        </tr>
    </tbody>
</table>
<!-- 无人机感知设备位置 -->
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
        <td><img src="./img/drone/drone.png" alt="Side view of drone" width="100"></td>
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
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
        </tr>
    </tbody>
</table>

<!-- 无人机通信设备位置 -->
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
        <td><img src="./img/drone/drone.png" alt="Side view of drone" width="100"></td>
        <td>UAV</td>
        <td>0</td>
        <td>0</td>
        <td>2</td>
        </tr>
    </tbody>
</table>


<!-- 路段感知设备位置 -->
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
      <td>-7.2</td>
      <td>-25</td>
      <td>0</td>
      <td>90</td>
      <td>100</td>
      <td rowspan="3">-0.2</td>
      <td rowspan="3">0</td>
      <td rowspan="3">4.3</td>
      <td rowspan="3">-40~0</td>
      <td rowspan="3">-180~180</td>
      <td rowspan="3">-0.2</td>
      <td rowspan="3">0</td>
      <td rowspan="3">-0.8</td>
      <td rowspan="3">-10~10</td>
      <td rowspan="3">-90~90</td>
    </tr>
    <tr>
      <td>Middle</td>
      <td>5</td>
      <td>0</td>
      <td>-7.2</td>
      <td>-25</td>
      <td>0</td>
      <td>0</td>
      <td>100</td>
    </tr>
    <tr>
      <td>Right</td>
      <td>4.8</td>
      <td>0</td>
      <td>-7.2</td>
      <td>-25</td>
      <td>0</td>
      <td>-90</td>
      <td>100</td>
    </tr>
    <!-- Additional rows for other data as needed -->
  </tbody>
</table>

<!-- 路段设备位置 -->
<table>
  <thead>
    <tr>
      <th rowspan="3">Name</th>
      <th colspan="3" style="text-align: center;">Communication Euipment</th>
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
      <td>0.8</td>
      <td>0</td>
      <td>-3.4</td>
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


<!-- 路端设备位置 -->
## RSF position

The deployment of RSFs is the same across different traffic density scenarios, and the table below describes the positions of RSFs in each scenario.


<table>
  <thead>
    <tr>
      <th>ID</th>
      <th>X(m)</th>
      <th>Y(m)</th>
      <th>Z(m)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>RSF1</td>
      <td>-42.4</td>
      <td>-84.6</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF2</td>
      <td>-47.9</td>
      <td>-34.3</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF3</td>
      <td>6.3</td>
      <td>-27.4</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF4</td>
      <td>4.0</td>
      <td>-81.6</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF5</td>
      <td>-42.4</td>
      <td>-255.7</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF6</td>
      <td>-0.7</td>
      <td>-289.6</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF7</td>
      <td>-213.9</td>
      <td>-34.3</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF8</td>
      <td>-331</td>
      <td>-79.7</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF9</td>
      <td>6.2</td>
      <td>118.5</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF10</td>
      <td>-42.6</td>
      <td>219.7</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF11</td>
      <td>153.8</td>
      <td>-79.7</td>
      <td>0</td>
    </tr>
    <tr>
      <td>RSF12</td>
      <td>244.8</td>
      <td>-31.8</td>
      <td>0</td>
    </tr>
  </tbody>
</table>

**X, Y, Z:** These three parameters collectively describe the three-dimensional spatial position of the RSF in the scenario, with the unit in meters.

**Pitch, Roll, Yaw:** These three parameters describe the three rotational angles of the RSF in the scenario, with the unit in degrees. Pitch represents the pitch angle, Roll represents the roll angle, and Yaw represents the yaw angle. They define the spatial attitude of the RSF.


<img src="./img/wide_road/wide_road_OverLook.png" alt="Description of your image" width="600" height="400">

## Correspondence between vehicle types and Car ID under different intelligent agent densities

<table>
  <tr>
    <th rowspan="2">Type</th>
    <th colspan="3" style="text-align: center;">Car ID under different intelligent agent densities</th>
  </tr>
  <tr>
    <th>Low</th>
  </tr>
  <tr>
    <td>Blue SUV</td>
    <td>2 3 4 8 10 11 13 14 17 20 24</td>
   </tr>
  <tr>
    <td>Mini Cooper</td>
    <td>9 12 16 18 23</td>
  </tr>
  <tr>
    <td>Sedan</td>
    <td>1 5 6 15 22</td>
   </tr>
  <tr>
    <td>Pickup</td>
    <td>19 21</td>
   </tr>
  <tr>
    <td>Box truck</td>
    <td>7</td>
   </tr>
  <tr>
    <td>Concrete</td>
    <td>NaN</td>
   </tr>
  <tr>
    <td>Refuse truck</td>
    <td>NaN</td>
  </tr>
  <tr>
    <td>School bus</td>
    <td>25</td>
  </tr>
  <tr>
    <td>Tank</td>
    <td>NaN</td>
  </tr>
</table>
<p><strong>Note:</strong> In the table below, "NaN" indicates that the type is not applicable.</p>



## Intelligent Agent Trajectory

The vehicle pose information for each frame is represented as follows:

- The first 3 columns represent the x, y, and z coordinates of the vehicle in that frame, in meters.
- The next 3 columns represent the roll, pitch, and yaw angles of the vehicle in that frame, in radians.
- The last column represents the frame number.

| Traffic Density | Folder Link                                                  |
| --------------- | ------------------------------------------------------------ |
| Low             | [Low Traffic Density Folder](link/to/low/traffic/density/folder) | 



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
        <tr><td>Car5</td><td>100</td><td>1242</td></tr>
        <tr><td>UAV1</td><td>1</td><td>1500</td></tr>
</table>
<p><strong>Note:</strong> In the table below, "NaN" indicates that The vehicle is not involved in the simulation.</p>

