FROM ubuntu:22.04

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
RUN ls
RUN git clone -b v1.16.0-alpha1 https://github.com/PX4/PX4-Autopilot.git --recursive
RUN bash /home/grvc/PX4-Autopilot/Tools/setup/ubuntu.sh 
WORKDIR /home/grvc/PX4-Autopilot
RUN make px4_sitl
