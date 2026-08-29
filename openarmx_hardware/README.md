# openarmx_hardware

English | [中文](./README-CN.md)

---

ros2_control hardware interface plugin for the OpenArmX V10 robot arm.

## Overview

This package implements a `hardware_interface::SystemInterface` plugin that communicates with OpenArmX motors via CAN bus. It supports:

- 7-DOF arm control (joints 1-7) with optional gripper (joint 8)
- Two control modes: MIT (motion control with KP/KD) and CSP (cyclic synchronous position)
- Both CAN 2.0 and CAN-FD communication
- Bimanual operation (left/right arm prefix)
- Dynamic runtime KP/KD parameter adjustment
- Gripper stall detection and protection

## Hardware Interface

The plugin exports the following interfaces per joint:

**State interfaces:** position, velocity, effort  
**Command interfaces:** position, velocity, effort

## Configuration

The hardware interface is configured via xacro parameters in the URDF `ros2_control` section:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `can_interface` | `can0` | CAN bus interface name |
| `arm_prefix` | `` | Arm prefix (`left_` or `right_` for bimanual) |
| `hand` | `true` | Enable gripper motor |
| `can_fd` | `false` | Use CAN-FD instead of CAN 2.0 |
| `control_mode` | `mit` | Motor control mode (`mit` or `csp`) |

## Usage

### Build

```bash
cd ~/openflex_all/openflex_ws
colcon build --packages-select openarmx_hardware
source install/setup.bash
```

### Plugin Registration

The plugin is registered as `openarmx_hardware/OpenArmX_v10HW` in `openarmx_hardware.xml` and loaded automatically by the ros2_control framework when specified in the URDF.

### Dynamic KP/KD Tuning

In MIT mode, KP and KD values can be adjusted at runtime:

```bash
# Adjust KP for joint 1 on right arm
\nEnglish | [中文](./README-CN.md)

---
ros2 param set /openarmx_right_hardware_params kp_joint1 60.0

# Adjust KD for joint 5 on left arm
\nEnglish | [中文](./README-CN.md)

---
ros2 param set /openarmx_left_hardware_params kd_joint5 1.0
```

Default values:
- Joints 1-4: KP=50.0, KD=2.5
- Joints 5-7: KP=10.0, KD=0.5
- Joint 8 (gripper): KP=50.0, KD=2.5

## Motor Configuration

| Joint | Motor Type | Direction |
|-------|-----------|-----------|
| 1-7 | RS04/RS03/RS00 (configurable) | Inverted (-1.0) |
| 8 (gripper) | RS00 | Position mapped: 0-0.044m joint space to 0 to -1.0472 rad motor space |

## Dependencies

- `rclcpp`
- `hardware_interface`
- `pluginlib`
- `openarmx` (CAN driver library)

## Prerequisites

- CAN interface active: `sudo ip link set can0 up type can bitrate 1000000`
- For CAN-FD: `sudo ip link set can0 up type can bitrate 1000000 dbitrate 5000000 fd on`
- OpenArmX motors powered and responding on the CAN bus

## License

CC-BY-NC-SA-4.0 - Chengdu Changshu Robot Co., Ltd.
