# openarmx_preview_bringup

English | [中文](./README-CN.md)

---

Bringup package for OpenArmX bimanual robot with RViz panel-based control and robot model preview.

## Overview

This package provides launch files that combine the standard OpenArmX bimanual bringup with an RViz configuration that includes the Joint Slider Panel plugin. It offers a visual interface for directly controlling the robot through sliders with real-time TF preview of target poses.

Two launch variants are provided:
- `openarmx.preview.bimanual.launch.py` - Standard bringup with RViz panel (no motor safety check)
- `openarmx.bimanual.launch.py` - Full bringup with motor angle safety check at startup

## Usage

### Build

```bash
cd ~/openflex_all/openflex_ws
colcon build --packages-select openarmx_preview_bringup
source install/setup.bash
```

### Launch

```bash
# Standard preview bringup (no motor check)
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py

# With simulated hardware
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py use_fake_hardware:=true

# Forward position controller mode (for slider control)
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py robot_controller:=forward_position_controller
```

### Launch Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `arm_type` | `v10` | Arm variant |
| `use_fake_hardware` | `false` | Use simulated hardware |
| `robot_controller` | `joint_trajectory_controller` | Controller type |
| `right_can_interface` | `can0` | Right arm CAN interface |
| `left_can_interface` | `can1` | Left arm CAN interface |
| `can_fd` | `false` | Enable CAN-FD |
| `control_mode` | `mit` | Motor control mode (`mit` or `csp`) |
| `enable_forward_effort` | `false` | Enable gravity compensation |

## Features

- Pre-configured RViz layout with Joint Slider Panel plugin loaded
- Real-time ghost model preview showing target pose before execution
- Stepped motion execution for safe joint movements
- Supports both forward_position_controller and joint_trajectory_controller modes

## Dependencies

- `openarmx_description`
- `openarmx_bringup` (controller configs)
- `openarmx_joint_slider_panel`
- `controller_manager`
- `robot_state_publisher`
- `rviz2`

## License

OpenArmX Research and Education License - Chengdu Changshu Robot Co., Ltd.
