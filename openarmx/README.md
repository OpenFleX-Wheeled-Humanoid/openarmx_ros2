# openarmx (Metapackage)

English | [中文](./README-CN.md)

---

ROS 2 metapackage that aggregates the core OpenArmX packages for convenient installation and dependency management.

## Overview

This is a metapackage with no code of its own. It declares dependencies on the essential OpenArmX packages so that installing `openarmx` pulls in everything needed to run the robot.

## Included Packages

| Package | Description |
|---------|-------------|
| `openarmx_bringup` | Launch files for bringing up the bimanual robot |
| `openarmx_description` | URDF/Xacro robot model and meshes |
| `openarmx_hardware` | ros2_control hardware interface for OpenArmX motors |

## Usage

### Build

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx
source install/setup.bash
```

### Install All Core Packages

Building this metapackage ensures all core runtime dependencies are available:

```bash
colcon build --packages-up-to openarmx
```

## License

CC-BY-NC-SA-4.0 - Chengdu Changshu Robot Co., Ltd.
