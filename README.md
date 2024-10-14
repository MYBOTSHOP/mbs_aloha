# mbs_aloha
A ros1 package for aloha v2

- Dependencies
```bash
sudo apt-get install ros-noetic-usb-cam && sudo apt-get install ros-noetic-cv-bridge
```

```bash
pip install torchvision
pip install torch
pip install pyquaternion
pip install pyyaml
pip install rospkg
pip install pexpect
pip install mujoco==2.3.7
pip install dm_control==1.0.14
pip install opencv-python
pip install matplotlib
pip install einops
pip install packaging
pip install h5py
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

- Launch teleop

```bash
roslaunch aloha 4arms_teleop.launch
```