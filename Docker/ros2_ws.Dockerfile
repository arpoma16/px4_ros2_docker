FROM px4-ros2-ros2:v1.0 

RUN mkdir -p /home/grvc/ros2_ws/src
WORKDIR /home/grvc/ros2_ws/src
RUN git clone https://github.com/PX4/px4_msgs.git -b release/1.15
#RUN git clone https://github.com/gazebosim/ros_gz.git -b humble
RUN rosdep init || true \
    && rosdep update
RUN  cd /home/grvc/ros2_ws/src && rosdep install -r --from-paths . -i -y --rosdistro humble

WORKDIR /home/grvc/ros2_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

RUN sudo echo "source /home/grvc/ros2_ws/install/setup.bash" >> /root/.bashrc

RUN mkdir -p /home/grvc/ros2_ws/src/external

RUN apt install libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor-dev -y
