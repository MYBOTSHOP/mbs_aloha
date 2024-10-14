# MBS Aloha
A ros1 package for aloha v2

## Operation

- Launch teleop driver

```bash
roslaunch aloha 4arms_teleop.launch
```

- Launch right arm

```bash
rosrun aloha right_side_teleop.py
```


- Launch left arm


```bash
rosrun aloha left_side_teleop.py
```

- Launch viz

```bash
roslaunch aloha_viz view_robot.launch
```

## Setup
- Dependencies

```bash
./dependencies.sh
```

- Check dynamixel

```bash
Open Dynamixel wizard, go into options and select:

Protocal 2.0
All ports
1000000 bps
ID range from 0-10
```

- Limit current 

```bash
Set max current for gripper motors

Open Dynamixel Wizard, and select the wrist motor for puppet arms. The name of it should be [ID:009] XM430-W350
Tip: the LED on the base of robot will flash when it is talking to Dynamixel Wizard. This will help determine which robot is selected.
Find 38 Current Limit, enter 200, then hit save at the bottom.
Repeat this for both puppet robots.
This limits the max current through gripper motors, to prevent overloading errors.
```

- Update aloha udev

```bash
sudo udevadm info --name=/dev/ttyUSB0 --attribute-walk | grep serial
sudo udevadm info --name=/dev/ttyUSB1 --attribute-walk | grep serial
sudo udevadm info --name=/dev/ttyUSB2 --attribute-walk | grep serial
sudo udevadm info --name=/dev/ttyUSB3 --attribute-walk | grep serial
```

```bash
sudo udevadm info --name=/dev/video0 --attribute-walk | grep serial
sudo udevadm info --name=/dev/video1 --attribute-walk | grep serial
sudo udevadm info --name=/dev/video2 --attribute-walk | grep serial
sudo udevadm info --name=/dev/video3 --attribute-walk | grep serial
```
to obtain the serial number. Use the first one that shows up, the format should look similar to ``FT6S4DSP``.


- To apply the changes, run 
```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
```