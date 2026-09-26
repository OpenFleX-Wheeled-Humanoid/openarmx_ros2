# openarmx_bimanual_moveit_config

English | [中文](./README-CN.md)

---

MoveIt 2 configuration package for the OpenArmX bimanual (dual-arm) robot setup.

## Overview

This package provides the MoveIt 2 motion planning configuration for the OpenArmX bimanual robot, generated and customized via the MoveIt Setup Assistant. It includes SRDF, kinematics configuration, joint limits, controller mappings, and launch files for running MoveIt with the real hardware or in simulation.

## Key Files

| File | Description |
|------|-------------|
| `config/openarmx_bimanual.srdf` | Semantic Robot Description (planning groups, collision pairs) |
| `config/kinematics.yaml` | IK solver configuration |
| `config/joint_limits.yaml` | Joint velocity/acceleration limits for planning |
| `config/pilz_cartesian_limits.yaml` | Cartesian limits for Pilz industrial planner |
| `config/ros2_controllers.yaml` | Controller definitions for ros2_control |
| `config/moveit_controllers.yaml` | MoveIt controller interface mapping |
| `config/initial_positions.yaml` | Default joint positions |
| `config/moveit.rviz` | RViz configuration for MoveIt visualization |

## Usage

### Build

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_bimanual_moveit_config
source install/setup.bash
```

### Launch MoveIt with Real Hardware

```bash
# Full stack: hardware + MoveIt + RViz
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bimanual_moveit_config demo.launch.py use_fake_hardware:=false
```

### Launch MoveIt in Simulation

```bash
# Simulated hardware (no CAN required)
\nEnglish | [中文](./README-CN.md)

---
ros2 launch openarmx_bimanual_moveit_config demo_sim.launch.py
```

### Launch Arguments (demo.launch.py)

| Argument | Default | Description |
|----------|---------|-------------|
| `arm_type` | `v10` | Arm variant |
| `use_fake_hardware` | `false` | Use simulated hardware |
| `robot_controller` | `joint_trajectory_controller` | Controller type (`joint_trajectory_controller` or `forward_position_controller`) |
| `right_can_interface` | `can0` | CAN interface for right arm |
| `left_can_interface` | `can1` | CAN interface for left arm |
| `can_fd` | `false` | Enable CAN-FD mode |
| `control_mode` | `mit` | Motor control mode (`mit` or `csp`) |
| `enable_forward_effort` | `false` | Enable gravity compensation feedforward |

### Helper Scripts

```bash
# Quick launch with simulation
\nEnglish | [中文](./README-CN.md)

---
bash run_bimanual_moveit_sim.sh

# Quick launch with CAN 2.0 hardware
\nEnglish | [中文](./README-CN.md)

---
bash run_bimanual_moveit_with_can2.0.sh
```

## Dependencies

- `moveit_ros_move_group`
- `moveit_kinematics`
- `moveit_planners`
- `moveit_simple_controller_manager`
- `moveit_configs_utils`
- `openarmx_description`
- `controller_manager`
- `robot_state_publisher`
- `rviz2`

## License

CC-BY-NC-SA-4.0 - Chengdu Changshu Robot Co., Ltd.
