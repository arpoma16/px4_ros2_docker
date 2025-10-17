docker build -t px4-ros2-microdds:v1.0 -f microdds.Dockerfile .
docker build -t px4-ros2-px4:v1.0 -f px4_gz.Dockerfile .
docker build -t px4-ros2-ros2:v1.0 -f ros2.Dockerfile .
docker build -t px4-ros2:humble -f ros2_ws.Dockerfile .
