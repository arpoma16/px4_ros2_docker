FROM ros2-microdds:humble

RUN apt-get update
RUN apt-get upgrade -y

# Install basic tools
RUN apt-get install -y git

# Install dependencies
RUN apt-get install -y lsb-release
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN apt-get install -y sudo


WORKDIR /root/
RUN mkdir -p /root/setup/
ADD ./Docker/setup_px4/requirements.txt /root/setup/
ADD ./Docker/setup_px4/ubuntu_setup.sh /root/setup/
RUN bash /root/setup/ubuntu_setup.sh

RUN git clone -b v1.15.4 https://github.com/PX4/PX4-Autopilot.git --recursive

WORKDIR /root/PX4-Autopilot
RUN make px4_sitl
