# openarmx_preview_bringup

[English](./README.md) | 中文

---

带 RViz 面板控制和机器人模型预览的 OpenArmX 双臂启动包。

## 概述

本包提供将标准 OpenArmX 双臂启动与包含关节滑块面板插件的 RViz 配置相结合的启动文件。通过滑块直接控制机器人，同时提供目标姿态的实时 TF 预览。

提供两种启动变体：
- `openarmx.preview.bimanual.launch.py` - 标准启动 + RViz 面板（无电机安全检查）
- `openarmx.bimanual.launch.py` - 完整启动，含启动时电机角度安全检查

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_preview_bringup
source install/setup.bash
```

### 启动

```bash
# 标准预览启动（无电机检查）
\n[English](./README.md) | 中文

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py

# 使用仿真硬件
\n[English](./README.md) | 中文

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py use_fake_hardware:=true

# 前馈位置控制器模式（用于滑块控制）
\n[English](./README.md) | 中文

---
ros2 launch openarmx_preview_bringup openarmx.preview.bimanual.launch.py robot_controller:=forward_position_controller
```

### 启动参数

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `arm_type` | `v10` | 机械臂型号 |
| `use_fake_hardware` | `false` | 使用仿真硬件 |
| `robot_controller` | `joint_trajectory_controller` | 控制器类型 |
| `right_can_interface` | `can0` | 右臂 CAN 接口 |
| `left_can_interface` | `can1` | 左臂 CAN 接口 |
| `can_fd` | `false` | 启用 CAN-FD |
| `control_mode` | `mit` | 电机控制模式（`mit` 或 `csp`） |
| `enable_forward_effort` | `false` | 启用重力补偿 |

## 功能特性

- 预配置的 RViz 布局，已加载关节滑块面板插件
- 实时半透明模型预览，在执行前显示目标姿态
- 分步运动执行，确保安全的关节运动
- 支持 forward_position_controller 和 joint_trajectory_controller 两种模式

## 依赖

- `openarmx_description`
- `openarmx_bringup`（控制器配置）
- `openarmx_joint_slider_panel`
- `controller_manager`
- `robot_state_publisher`
- `rviz2`

## 许可证

OpenArmX 研究和教育许可证 - 成都长树机器人有限公司
