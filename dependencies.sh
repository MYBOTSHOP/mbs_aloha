#!/usr/bin/env bash

# Software License Agreement (BSD)
#
# @author    Salman Omar Sohail <support@mybotshop.de>
# @copyright (c) 2024, MYBOTSHOP GmbH, Inc., All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, is not permitted without the express permission
# of MYBOTSHOP GmbH.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

function color_echo () {
    echo "$(tput setaf 1)$1$(tput sgr0)"
}


function install_ros2_dependencies () {
    color_echo "Installing build pacakges."
    sudo apt-get install openssh*\
                         chrony\
                         sshpass\
                         neofetch\
                         v4l-utils\
                         libpcl-dev build-essential\
                         cmake\
                         libglfw3-dev\
                         libglew-dev\
                         libjsoncpp-dev\
                         libtclap-dev\
                         libeigen3-dev\
                         libboost-all-dev\
                         libboost-date-time-dev\
                         libavcodec-dev\
                         libavformat-dev\
                         libavutil-dev\
                         libswscale-dev\
                         libgtk-3-dev\
                         git\
                         libbullet-dev \
                         python3-colcon-common-extensions \
                         python3-flake8 \
                         python3-pip \
                         python3-pytest-cov \
                         python3-rosdep \
                         python3-setuptools \
                         python3-vcstool \
                         espeak-ng \
                         wget -y
    
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
    pip install ipython

    color_echo "Installing build pacakges."
}

function install_ros2_core_packages () {
    color_echo "Installing build pacakges."
    sudo apt-get install ros-noetic-usb-cam\
                         ros-noetic-cv-bridge -y
}

RED='\033[0;31m'
DGREEN='\033[0;32m'
GREEN='\033[1;32m'
WHITE='\033[0;37m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' 
                                                                                          
echo -e "${DGREEN}"
echo -e "  _  _  _  _  ____   __  ____  ____  _  _   __  ____  "
echo -e " ( \/ )( \/ )(  _ \ /  \(_  _)/ ___)/ )( \ /  \(  _ \ "
echo -e " / \/ \ )  /  ) _ ((  O ) )(  \___ \) __ ((  O )) __/ "
echo -e " \_)(_/(__/  (____/ \__/ (__) (____/\_)(_/ \__/(__)   "
echo -e "------------------------------------------------------"
echo -e "Installing Required Libraries and ROS dependencies!   "                                                                                                                                         
echo -e "------------------------------------------------------${NC}"

install_ros2_dependencies
install_ros2_core_packages

echo "Installation complete."