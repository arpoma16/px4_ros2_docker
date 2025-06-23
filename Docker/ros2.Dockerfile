From ros:humble

RUN sudo apt-get install -y cmake
RUN mkdir -p /home/grvc/px4msgs_ws/src
WORKDIR /home/grvc/px4msgs_ws/src
RUN git clone https://github.com/PX4/px4_msgs.git -b release/1.15
WORKDIR /home/grvc/px4msgs_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

RUN sudo echo "source /home/grvc/px4msgs_ws/install/setup.bash" >> /home/grvc/.bashrc