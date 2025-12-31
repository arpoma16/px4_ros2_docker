FROM ros2-px4:humble 

RUN apt install -y libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor-dev
RUN apt install -y ros-humble-rosbridge-library ros-humble-rosbridge-server
RUN apt install -y ros-humble-rosbridge-server
RUN apt install -y ros-humble-ros-gzharmonic
RUN apt install -y ros-humble-ffmpeg-image-transport

RUN apt-get -y install python3-geographiclib

RUN pip3 uninstall -y numpy opencv-python || true && \
    pip3 install --no-cache-dir 'numpy<2' 'opencv-python<4.10'

RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws/src

RUN git clone https://github.com/PX4/px4_msgs.git -b release/1.15
#RUN git clone https://github.com/gazebosim/ros_gz.git -b humble

RUN  cd /root/ros2_ws/src && rosdep install -r --from-paths . -i -y --rosdistro humble

WORKDIR /root/ros2_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"
RUN echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc

# download PX4-gazebo-models
#RUN cp -r /root/PX4-Autopilot/Tools/simulation/gz /root/PX4-gazebo-models
RUN git clone https://github.com/PX4/PX4-gazebo-models.git && \
    cd PX4-gazebo-models && \
    git checkout e05f4312d3f28aa621157610584a4870406cb6d3
# set environment variables for gz
RUN echo "export GZ_PARTITION=docker_sim_harmonic" >> /root/.bashrc
RUN echo "export GZ_SIM_RESOURCE_PATH=/root/PX4-gazebo-models/models" >> /root/.bashrc
RUN echo "export GZ_SIM_SERVER_CONFIG_PATH=/root/PX4-gazebo-models/server.config" >> /root/.bashrc

#RUN cd /root/PX4-gazebo-models && \
#    python3 simulation-gazebo --dryrun


# setup external folder for volumen
RUN mkdir -p /root/ros2_ws/src/external