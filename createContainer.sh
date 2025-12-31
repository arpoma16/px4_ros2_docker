docker build -t ros2-desktop:humble -f Docker/ros2.Dockerfile . && \
docker build -t ros2-microdds:humble -f Docker/microdds.Dockerfile . && \
docker build -t ros2-px4:humble -f Docker/px4_gz.Dockerfile . && \
docker build -t ros2-px4-ws:humble -f Docker/ros2_ws.Dockerfile .
