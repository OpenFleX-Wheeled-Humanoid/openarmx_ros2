# openarmx_gravity_comp

English | [中文](./README-CN.md)

---

Gravity compensation feedforward node for OpenArmX bimanual arms using KDL dynamics.

## Overview

This package computes real-time gravity torques for the OpenArmX bimanual robot and publishes them to forward effort controllers. It uses the Orocos KDL library to solve the inverse dynamics (gravity-only) given the current joint positions from `/joint_states`.

## How It Works

1. Loads the URDF and builds KDL chains for left and right arms (from `openarmx_left_link0` to `openarmx_left_link7`, and similarly for right)
2. Subscribes to `/joint_states` for current joint positions
3. Computes gravity torques using KDL inverse dynamics with the gravity vector rotated into each arm's base frame
4. Scales the torques by a configurable `g_scale` factor
5. Clamps per-joint torques to safety limits (20 Nm for joints 1-2, 7 Nm for joints 3-4, 2 Nm for joints 5-7)
6. Publishes the torque commands to the effort controllers

## Usage

### Build

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_gravity_comp
source install/setup.bash
```

### Run Standalone

```bash
ros2 run openarmx_gravity_comp gravity_comp_node --ros-args \
  -p urdf_path:=/tmp/v10_bimanual_gravity.urdf \
  -p g_scale:=1.05 \
  -p enable_left:=true \
  -p enable_right:=true
```

### Typical Usage (via bringup)

The gravity compensation node is normally launched automatically by `openarmx_bringup` or `openarmx_preview_bringup` when `enable_forward_effort:=true`:

```bash
ros2 launch openarmx_bringup openarmx.bimanual.launch.py enable_forward_effort:=true
```

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `urdf_path` | `` (required) | Path to URDF file for KDL chain construction |
| `g_scale` | `1.05` | Gravity torque scaling factor (tunable at runtime) |
| `enable_left` | `true` | Enable left arm compensation |
| `enable_right` | `true` | Enable right arm compensation |
| `verbose` | `false` | Print per-joint torque debug info |

## Topics

### Subscribed

| Topic | Type | Description |
|-------|------|-------------|
| `/joint_states` | `sensor_msgs/JointState` | Current joint positions |

### Published

| Topic | Type | Description |
|-------|------|-------------|
| `/left_forward_effort_controller/commands` | `std_msgs/Float64MultiArray` | Left arm gravity torques (7 values) |
| `/right_forward_effort_controller/commands` | `std_msgs/Float64MultiArray` | Right arm gravity torques (7 values) |

## Dependencies

- `rclcpp`, `sensor_msgs`, `std_msgs`
- `orocos_kdl`, `kdl_parser`
- `urdf`, `urdfdom`, `urdfdom_headers`
- `Eigen3`

## Notes

- The gravity vector is configured per-arm based on the mounting orientation (right arm: gy=-9.81, left arm: gy=+9.81)
- Direction correction is handled by the hardware interface write(), not by this node
- The `g_scale` parameter can be adjusted at runtime via `ros2 param set`

## License

CC-BY-NC-SA-4.0 - Chengdu Changshu Robot Co., Ltd.
