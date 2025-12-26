# Install ROS2 HUMBLE
FROM ubuntu:22.04   

RUN apt-get update
RUN apt-get upgrade -y

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

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool 

RUN rosdep init && \
  rosdep update --rosdistro humble

RUN pip3 uninstall -y numpy opencv-python || true && \
    pip3 install --no-cache-dir 'numpy<2' 'opencv-python<4.10'
