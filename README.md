# Docker ROS2 PX4 Environment

This repository contains a container image for working with PX4 ROS2 Humble on Ubuntu 22.04 with :

- [ROS 2 Humble](https://docs.ros.org/en/humble/index.html)
- [Gazebo Harmonic](https://gazebosim.org/docs/harmonic/getstarted/)
- [PX4 v1.15.4](https://github.com/PX4/PX4-Autopilot/tree/v1.16.0-alpha1)
- [Micro-XRCE v3.0.1](https://github.com/eProsima/Micro-XRCE-DDS-Agent/tree/v3.0.1)
- [ROS 2 package `px4_msgs` release 1.15](https://github.com/PX4/px4_msgs/tree/release/1.15)

## Requirements

Before getting started, ensure you have the following installed on your system:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/) (optional, if you want to use `docker-compose`)

## Building the Image

To build the Docker image, run the following command:

```bash
.createContainer
```

This will generate a Docker image with the necessary dependencies for working with PX4 and ROS 2 Humble.

## Using the Image

This image is developed as a development environment for testing software with ROS2 and PX4. You can run it using different methods:

### Option 1: DevContainer with Auto-Detection (Recommended) ⭐

The project includes **automatic GPU detection** that configures the devcontainer appropriately:

```bash
# Auto-detect hardware and configure
bash .devcontainer/select-config.sh

# Then open in VSCode
code .
```

In VSCode: Press `Ctrl + Shift + P` and select **"Dev Containers: Reopen in Container"**

This will automatically:
- Detect if you have NVIDIA GPU
- Configure network in host mode
- Set up all Docker privileges and configurations
- Select the appropriate devcontainer configuration

📖 For more details, see [.devcontainer/README.md](.devcontainer/README.md) or [.devcontainer/QUICKSTART.md](.devcontainer/QUICKSTART.md)

### Option 2: Using container_run.sh script

```bash
bash ./container_run.sh
```

### Option 3: Manual DevContainer

1. Install devcontainer extension
2. Press `Ctrl + Shift + P` and select "Dev Containers: Reopen in Container" or "Rebuild"

For multiple terminals in your container using devcontainer, I recommend using devcontainers CLI: https://github.com/devcontainers/cli

```bash
alias devcontainerhere="devcontainer exec --workspace-folder . bash"
alias devcontainerzsh="devcontainer exec --workspace-folder . zsh"
alias devcontainerup="devcontainer up --workspace-folder ."
```
# Tips 
you can review  commands in the folder tmuxinator. you could find a good examples of comands to run with px4

## Customization

If you want to modify the PX4, Micro-XRCE, or `px4_msgs` version, edit the `Dockerfile` and adjust the corresponding variables.

## Contact

If you have any questions or suggestions, feel free to open an issue or a pull request.


