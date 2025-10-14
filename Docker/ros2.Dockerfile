# Install ROS2 HUMBLE
FROM px4-ros2-px4:v1.0 

RUN sudo apt install -y locales
RUN sudo locale-gen en_US en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

# These lines are for ROS2 not ask region
ARG DEBIAN_FRONTEND=noninteractive
 
RUN sudo apt-get install -y software-properties-common
RUN sudo add-apt-repository universe

RUN sudo apt-get install -y curl
RUN sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN sudo apt-get update 
RUN sudo apt-get upgrade -y

RUN sudo apt install -y ros-humble-desktop

RUN sudo echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
RUN sudo /bin/bash -c "source /opt/ros/humble/setup.bash"

RUN sudo apt install -y python3-colcon-common-extensions
RUN sudo apt install -y python3-rosdep

RUN apt-get install -y ros-humble-rosbridge-server

# install ros GZ
RUN apt install -y ros-humble-ros-gzharmonic
