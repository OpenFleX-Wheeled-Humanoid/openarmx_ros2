# openarmx_bringup

English | [中文](./README-CN.md)

---

Bringup launch files and controller configurations for the OpenArmX bimanual robot.

## Overview

This package provides the primary launch file for starting the OpenArmX bimanual robot with ros2_control. It handles:

- Xacro processing and robot_state_publisher setup
- ros2_control node with hardware interface configuration
- Controller spawning (joint_state_broadcaster, position/trajectory controllers, gripper controllers)
- Optional gravity compensation feedforward
- RViz visualization

## Configuration Files

| File | Description |
|------|-------------|
| `config/v10_controllers/openarmx_v10_bimanual_controllers.yaml` | Controller definitions for bimanual setup |
| `config/v10_controllers/openarmx_v10_bimanual_controllers_namespaced.yaml` | Namespaced version for multi-robot |
| `config/v10_controllers/openarmx_v10_controllers.yaml` | Single-arm controller definitions |

## Usage

### Build

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_bringup
source install/setup.bash
```

### Launch Bimanual Robot

```bash
# Real hardware with MIT mode (default)
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py

# Simulated hardware
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py use_fake_hardware:=true

# With forward position controller
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py robot_controller:=forward_position_controller

# With gravity compensation
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py enable_forward_effort:=true
```

### Launch Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `description_package` | `openarmx_description` | Package containing URDF |
| `description_file` | `v10.urdf.xacro` | Xacro file name |
| `arm_type` | `v10` | Arm variant |
| `use_fake_hardware` | `false` | Use simulated hardware |
| `robot_controller` | `joint_trajectory_controller` | `forward_position_controller` or `joint_trajectory_controller` |
| `right_can_interface` | `can0` | CAN bus for right arm |
| `left_can_interface` | `can1` | CAN bus for left arm |
| `can_fd` | `false` | Enable CAN-FD |
| `control_mode` | `mit` | Motor control mode (`mit` or `csp`) |
| `arm_prefix` | `` | Namespace prefix for multi-robot |
| `enable_forward_effort` | `false` | Enable gravity compensation feedforward |

## Controllers Spawned

- `joint_state_broadcaster` - Publishes joint states
- `left_forward_position_controller` / `right_forward_position_controller` - Position commands (when using forward_position_controller)
- `left_joint_trajectory_controller` / `right_joint_trajectory_controller` - Trajectory execution (when using joint_trajectory_controller)
- `left_gripper_controller` / `right_gripper_controller` - Gripper action controllers (only with joint_trajectory_controller)
- `left_forward_effort_controller` / `right_forward_effort_controller` - Effort feedforward (when enable_forward_effort=true)

## Topics

| Topic | Type | Description |
|-------|------|-------------|
| `/joint_states` | `sensor_msgs/JointState` | Joint positions, velocities, efforts |
| `/left_forward_position_controller/commands` | `std_msgs/Float64MultiArray` | Left arm position commands |
| `/right_forward_position_controller/commands` | `std_msgs/Float64MultiArray` | Right arm position commands |

## Prerequisites

- CAN interfaces configured and active (`can0`, `can1`)
- OpenArmX motors powered on and at zero position
- `openarmx_hardware` package built

## License

CC-BY-NC-SA-4.0 - Chengdu Changshu Robot Co., Ltd.
