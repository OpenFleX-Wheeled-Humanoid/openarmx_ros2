# openarmx_bimanual_moveit_config

[English](./README.md) | 中文

---

OpenArmX 双臂机器人的 MoveIt 2 运动规划配置包。

## 概述

本包提供 OpenArmX 双臂机器人的 MoveIt 2 运动规划配置，通过 MoveIt Setup Assistant 生成并自定义。包含 SRDF、运动学配置、关节限位、控制器映射，以及用于真实硬件或仿真运行 MoveIt 的启动文件。

## 关键文件

| 文件 | 描述 |
|------|------|
| `config/openarmx_bimanual.srdf` | 语义机器人描述（规划组、碰撞对） |
| `config/kinematics.yaml` | 逆运动学求解器配置 |
| `config/joint_limits.yaml` | 规划用的关节速度/加速度限位 |
| `config/pilz_cartesian_limits.yaml` | Pilz 工业规划器的笛卡尔限位 |
| `config/ros2_controllers.yaml` | ros2_control 控制器定义 |
| `config/moveit_controllers.yaml` | MoveIt 控制器接口映射 |
| `config/initial_positions.yaml` | 默认关节位置 |
| `config/moveit.rviz` | MoveIt 可视化 RViz 配置 |

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_bimanual_moveit_config
source install/setup.bash
```

### 使用真实硬件启动 MoveIt

```bash
# 完整启动：硬件 + MoveIt + RViz
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bimanual_moveit_config demo.launch.py use_fake_hardware:=false
```

### 仿真启动 MoveIt

```bash
# 仿真硬件（无需 CAN）
\n[English](./README.md) | 中文

---
ros2 launch openarmx_bimanual_moveit_config demo_sim.launch.py
```

### 启动参数（demo.launch.py）

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `arm_type` | `v10` | 机械臂型号 |
| `use_fake_hardware` | `false` | 使用仿真硬件 |
| `robot_controller` | `joint_trajectory_controller` | 控制器类型（`joint_trajectory_controller` 或 `forward_position_controller`） |
| `right_can_interface` | `can0` | 右臂 CAN 接口 |
| `left_can_interface` | `can1` | 左臂 CAN 接口 |
| `can_fd` | `false` | 启用 CAN-FD 模式 |
| `control_mode` | `mit` | 电机控制模式（`mit` 或 `csp`） |
| `enable_forward_effort` | `false` | 启用重力补偿前馈 |

### 辅助脚本

```bash
# 快速仿真启动
\n[English](./README.md) | 中文

---
bash run_bimanual_moveit_sim.sh

# 快速 CAN 2.0 硬件启动
\n[English](./README.md) | 中文

---
bash run_bimanual_moveit_with_can2.0.sh
```

## 依赖

- `moveit_ros_move_group`
- `moveit_kinematics`
- `moveit_planners`
- `moveit_simple_controller_manager`
- `moveit_configs_utils`
- `openarmx_description`
- `controller_manager`
- `robot_state_publisher`
- `rviz2`

## 许可证

CC-BY-NC-SA-4.0 - 成都长树机器人有限公司
