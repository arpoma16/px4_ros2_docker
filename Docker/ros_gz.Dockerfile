# Author: Fco Javier Roman
# email: fraromesc@gmail.com

FROM ubuntu:22.04


RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y sudo


# Install basic tools
RUN apt-get install -y git

# Install dependencies
RUN apt-get install -y lsb-release
RUN apt-get install -y gnupg
RUN apt-get install -y wget

# install gazebo harmonic 
RUN apt-get update
RUN apt-get install -y curl lsb-release gnupg
RUN curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt-get update
RUN apt-get install -y gz-harmonic

# Install ROS2 HUMBLE

RUN apt install -y locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

# These lines are for ROS2 not ask region
ARG DEBIAN_FRONTEND=noninteractive
 
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe

RUN apt-get install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update 
RUN apt-get upgrade -y

RUN apt install -y ros-humble-desktop

RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
RUN /bin/bash -c "source /opt/ros/humble/setup.bash"

RUN apt install -y python3-colcon-common-extensions
RUN apt install -y python3-rosdep

RUN apt-get install -y ros-humble-rosbridge-server

# install ros GZ

RUN apt install -y ros-humble-ros-gzharmonic
RUN apt-get update
# mejora de entorno grafico
RUN apt install libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor-dev -y
# installar gstreamer
RUN apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y

# paquetes adicionales solicitados
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --quiet --no-install-recommends install \
        dmidecode \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav \
        libeigen3-dev \
        libgstreamer-plugins-base1.0-dev \
        libimage-exiftool-perl \
        libopencv-dev \
        libxml2-utils \
        pkg-config \
        protobuf-compiler \
        ;