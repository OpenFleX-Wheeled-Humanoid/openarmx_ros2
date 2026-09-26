# openarmx_bringup

[English](./README.md) | 中文

---

OpenArmX 双臂机器人的启动文件和控制器配置包。

## 概述

本包提供启动 OpenArmX 双臂机器人（基于 ros2_control）的主要启动文件，负责：

- Xacro 处理及 robot_state_publisher 设置
- ros2_control 节点及硬件接口配置
- 控制器启动（joint_state_broadcaster、位置/轨迹控制器、夹爪控制器）
- 可选的重力补偿前馈
- RViz 可视化

## 配置文件

| 文件 | 描述 |
|------|------|
| `config/v10_controllers/openarmx_v10_bimanual_controllers.yaml` | 双臂控制器定义 |
| `config/v10_controllers/openarmx_v10_bimanual_controllers_namespaced.yaml` | 命名空间版本（多机器人） |
| `config/v10_controllers/openarmx_v10_controllers.yaml` | 单臂控制器定义 |

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_bringup
source install/setup.bash
```

### 启动双臂机器人

```bash
# 真实硬件，MIT 模式（默认）
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py

# 仿真硬件
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py use_fake_hardware:=true

# 使用前馈位置控制器
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py robot_controller:=forward_position_controller

# 启用重力补偿
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bringup openarmx.bimanual.launch.py enable_forward_effort:=true
```

### 启动参数

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `description_package` | `openarmx_description` | 包含 URDF 的功能包 |
| `description_file` | `v10.urdf.xacro` | Xacro 文件名 |
| `arm_type` | `v10` | 机械臂型号 |
| `use_fake_hardware` | `false` | 使用仿真硬件 |
| `robot_controller` | `joint_trajectory_controller` | `forward_position_controller` 或 `joint_trajectory_controller` |
| `right_can_interface` | `can0` | 右臂 CAN 总线 |
| `left_can_interface` | `can1` | 左臂 CAN 总线 |
| `can_fd` | `false` | 启用 CAN-FD |
| `control_mode` | `mit` | 电机控制模式（`mit` 或 `csp`） |
| `arm_prefix` | `` | 多机器人命名空间前缀 |
| `enable_forward_effort` | `false` | 启用重力补偿前馈 |

## 启动的控制器

- `joint_state_broadcaster` - 发布关节状态
- `left_forward_position_controller` / `right_forward_position_controller` - 位置指令（forward_position_controller 模式）
- `left_joint_trajectory_controller` / `right_joint_trajectory_controller` - 轨迹执行（joint_trajectory_controller 模式）
- `left_gripper_controller` / `right_gripper_controller` - 夹爪动作控制器（仅 joint_trajectory_controller 模式）
- `left_forward_effort_controller` / `right_forward_effort_controller` - 力矩前馈（enable_forward_effort=true 时）

## 话题

| 话题 | 类型 | 描述 |
|------|------|------|
| `/joint_states` | `sensor_msgs/JointState` | 关节位置、速度、力矩 |
| `/left_forward_position_controller/commands` | `std_msgs/Float64MultiArray` | 左臂位置指令 |
| `/right_forward_position_controller/commands` | `std_msgs/Float64MultiArray` | 右臂位置指令 |

## 前置条件

- CAN 接口已配置并激活（`can0`、`can1`）
- OpenArmX 电机已上电且处于零位
- `openarmx_hardware` 包已编译

## 许可证

CC-BY-NC-SA-4.0 - 成都长树机器人有限公司
