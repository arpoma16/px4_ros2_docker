docker build -t ros2-desktop:humble -f ros2.Dockerfile . && \
docker build -t ros2-microdds:humble -f microdds.Dockerfile . && \
docker build -t ros2-px4:humble -f px4_gz.Dockerfile . && \
docker build -t ros2-px4-ws:humble -f ros2_ws.Dockerfile .
