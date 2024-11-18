#  Data Collected by UAV

<img src="./img/crossing_road/UAV urban crossroad scenario.png" alt="Description of your image" width="500" height="">

## Description 

The scenario contains 11 roadside facilities (RSFs) and many trees. The UAV is equipped with communication devices and multi-modal sensors, including three cameras, two types of depth cameras (three each), and a LiDAR. The time interval between adjacent snapshots is 50 ms and the frame rate of the multi-modal sensory data at the UAV is 20 Hz. The frame rate of the communication data is also 20 Hz. The snapshots corresponding to all data are reflected in the filenames, such as "snapshot91_pointcloud.txt" for LiDAR point cloud data at snapshot 91 and "csi_95.mat" for the chanenl matrix at snapshot 95. The total duration of all three scenarios is 75 s with snapshots ranging from 1 to 1500.
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

The scenario includes vehicles of the **"Blue SUV"** type. The relative coordinate positions and parameter information of the sensors are given as follows:

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
        <td><img src="./img/crossing_road/car1_blue_SUV.png" alt="Side view of car1" width="100"></td>
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
        <td>-1</td>
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
        <td><img src="./img/crossing_road/car1_blue_SUV.png" alt="Side view of car1" width="100"></td>
        <td>Blue SUV</td>
        <td>-0.1</td>
        <td>0</td>
        <td>-1.4</td>
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
| **HorizontalFOVStart**      | -90       |
| **HorizontalFOVEnd**        | 90        |
| **VerticalFOVUpper**        | 0         |
| **VerticalFOVLower**        | -40       |



## RSF position

The deployment of RSFs is the same across different traffic density scenarios, and the table below describes the positions of RSFs in each scenario.

<table>
    <thead>
        <tr>
        <th rowspan="2">Name</th>
        <th colspan="5" style="text-align: center;">Camera</th>
        <th colspan="6" style="text-align: center;">LiDAR</th>
        <th colspan="6" style="text-align: center;">mmWave Radar</th>
        </tr>
        <tr>
        <th>Direction</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>FoV Degrees(°)</th>
        <th>Direction</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>Vertical FoV(°)</th>
        <th>Horizontal FoV(°)</th>
        <th>Direction</th>
        <th>X(m)</th>
        <th>Y(m)</th>
        <th>Z(m)</th>
        <th>Vertical FoV(°)</th>
        <th>Horizontal FoV(°)</th>
        </tr>
    </thead>
  <tbody>
    <tr>
        <td>RSF1</td>
        <td>-y</td>
        <td>143.776</td>
        <td>253.28</td>
        <td>3.3</td>
        <td>100</td>
        <td>-y</td>
        <td>143.776</td>
        <td>251.4</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-y</td>
        <td>143.776</td>
        <td>251.4</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF2</td>
        <td>-x</td>
        <td>196.579</td>
        <td>270.847</td>
        <td>3.3</td>
        <td>100</td>
        <td>-x</td>
        <td>196.579</td>
        <td>272.247</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-x</td>
        <td>196.579</td>
        <td>272.247</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF3</td>
        <td>+x</td>
        <td>169.681</td>
        <td>231.147</td>
        <td>3.3</td>
        <td>100</td>
        <td>+x</td>
        <td>169.681</td>
        <td>231.147</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>+x</td>
        <td>169.681</td>
        <td>231.147</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF4</td>
        <td>+y</td>
        <td>198.707</td>
        <td>231.264</td>
        <td>3.3</td>
        <td>100</td>
        <td>+y</td>
        <td>198.708</td>
        <td>233.764</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>+y</td>
        <td>198.708</td>
        <td>233.764</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
     <tr>
        <td>RSF5</td>
        <td>+x</td>
        <td>166.652</td>
        <td>298.833</td>
        <td>3.3</td>
        <td>100</td>
        <td>+x</td>
        <td>167.652</td>
        <td>298.833</td>
        <td>3.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>+x</td>
        <td>167.652</td>
        <td>298.833</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF6</td>
        <td>-x</td>
        <td>196.2</td>
        <td>200.808</td>
        <td>3.3</td>
        <td>100</td>
        <td>-x</td>
        <td>195</td>
        <td>200.808</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-x</td>
        <td>195</td>
        <td>200.808</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF7</td>
        <td>+x</td>
        <td>168.745</td>
        <td>180.552</td>
        <td>3.3</td>
        <td>100</td>
        <td>+x</td>
        <td>170</td>
        <td>180.552</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>+x</td>
        <td>170</td>
        <td>180.552</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF8</td>
        <td>+x</td>
        <td>168.230</td>
        <td>263.423</td>
        <td>3.3</td>
        <td>100</td>
        <td>+x</td>
        <td>170</td>
        <td>263.423</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>+x</td>
        <td>170</td>
        <td>263.423</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF9</td>
        <td>-x</td>
        <td>249.431</td>
        <td>245.660</td>
        <td>3.3</td>
        <td>100</td>
        <td>-x</td>
        <td>248.5</td>
        <td>245.660</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-x</td>
        <td>248.5</td>
        <td>245.660</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF10</td>
        <td>-x</td>
        <td>196.502</td>
        <td>301.954</td>
        <td>3.3</td>
        <td>100</td>
        <td>-x</td>
        <td>194.502</td>
        <td>301.954</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-x</td>
        <td>194.502</td>
        <td>301.954</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
    <tr>
        <td>RSF11</td>
        <td>-y</td>
        <td>219.057</td>
        <td>253.337</td>
        <td>3.3</td>
        <td>100</td>
        <td>-y</td>
        <td>219.057</td>
        <td>253.337</td>
        <td>2.3</td>
        <td>-40~0</td>
        <td>-90~90</td>
        <td>-y</td>
        <td>219.057</td>
        <td>253.337</td>
        <td>-0.8</td>
        <td>-10~10</td>
        <td>-90~90</td>
    </tr>
  </tbody>
</table>

<table>
    <thead>
        <tr>
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
        <td>RSF1</td>
        <td>143.8</td>
        <td>-253.3</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF2</td>
        <td>196.5</td>
        <td>-270.8</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF3</td>
        <td>169.7</td>
        <td>-231.3</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF4</td>
        <td>198.7</td>
        <td>-231.3</td>
        <td>-5</td>
    </tr>
     <tr>
        <td>RSF5</td>
        <td>166.7</td>
        <td>-298.8</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF6</td>
        <td>197.5</td>
        <td>-200.8</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF7</td>
        <td>168.7</td>
        <td>-180.6</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF8</td>
        <td>168.2</td>
        <td>-263.4</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF9</td>
        <td>249.4</td>
        <td>-245.7</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF10</td>
        <td>196.5</td>
        <td>-302.0</td>
        <td>-5</td>
    </tr>
    <tr>
        <td>RSF11</td>
        <td>219.1</td>
        <td>-253.3</td>
        <td>-5</td>
    </tr>
  </tbody>
</table>
 
<img src="./img/crossing_road/crossing_road_Overlook.png" alt="Description of your image" width="600" height="400">

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
    <th colspan="2" style="text-align: center;">Sunnyday_Morning_Medium intelligent agent density</th>
</tr>
  <tr>
            <th>Start Frame</th>
            <th>Stop Frame</th>
  </tr>
        <tr><td>Car1</td><td>1</td><td>1500</td></tr>
        <tr><td>UAV1</td><td>1</td><td>1500</td></tr>
</table>
<p><strong>Note:</strong> In the table below, "NaN" indicates that The vehicle is not involved in the simulation.</p>

