FROM px4-ros2-microdds:v1.0

RUN apt-get update
RUN apt-get upgrade -y

# Install basic tools
RUN apt-get install -y git

# Install dependencies
RUN apt-get install -y lsb-release
RUN apt-get install -y gnupg
RUN apt-get install -y wget

RUN mkdir -p /home/grvc/

WORKDIR /home/grvc/
RUN git clone -b v1.15.4 https://github.com/PX4/PX4-Autopilot.git --recursive
ADD ./setup_px4/ubuntu_setup.sh /home/grvc/PX4-Autopilot/Tools/setup/
RUN apt-get install -y sudo
RUN bash /home/grvc/PX4-Autopilot/Tools/setup/ubuntu_setup.sh 
WORKDIR /home/grvc/PX4-Autopilot
RUN make px4_sitl

RUN cd /home/grvc/PX4-Autopilot/Tools/simulation/gz && \
    python3 simulation-gazebo --dryrun