# openarmx_hardware

[English](./README.md) | 中文

---

OpenArmX V10 机器人的 ros2_control 硬件接口插件。

## 概述

本包实现了 `hardware_interface::SystemInterface` 插件，通过 CAN 总线与 OpenArmX 电机通信。支持：

- 7 自由度机械臂控制（关节 1-7）及可选夹爪（关节 8）
- 两种控制模式：MIT（带 KP/KD 的运动控制）和 CSP（周期同步位置）
- CAN 2.0 和 CAN-FD 通信
- 双臂操作（左/右臂前缀）
- 运行时动态 KP/KD 参数调整
- 夹爪堵转检测和保护

## 硬件接口

插件为每个关节导出以下接口：

**状态接口：** position（位置）、velocity（速度）、effort（力矩）  
**命令接口：** position（位置）、velocity（速度）、effort（力矩）

## 配置

硬件接口通过 URDF 中 `ros2_control` 部分的 xacro 参数配置：

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `can_interface` | `can0` | CAN 总线接口名称 |
| `arm_prefix` | `` | 臂前缀（双臂时为 `left_` 或 `right_`） |
| `hand` | `true` | 启用夹爪电机 |
| `can_fd` | `false` | 使用 CAN-FD 替代 CAN 2.0 |
| `control_mode` | `mit` | 电机控制模式（`mit` 或 `csp`） |

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_hardware
source install/setup.bash
```

### 插件注册

插件以 `openarmx_hardware/OpenArmX_v10HW` 注册在 `openarmx_hardware.xml` 中，在 URDF 中指定后由 ros2_control 框架自动加载。

### 动态 KP/KD 调整

MIT 模式下，KP 和 KD 值可在运行时调整：

```bash
# 调整右臂关节 1 的 KP
\n[English](./README.md) | 中文

---
ros2 param set /openarmx_right_hardware_params kp_joint1 60.0

# 调整左臂关节 5 的 KD
\n[English](./README.md) | 中文

---
ros2 param set /openarmx_left_hardware_params kd_joint5 1.0
```

默认值：
- 关节 1-4：KP=50.0，KD=2.5
- 关节 5-7：KP=10.0，KD=0.5
- 关节 8（夹爪）：KP=50.0，KD=2.5

## 电机配置

| 关节 | 电机型号 | 方向 |
|------|---------|------|
| 1-7 | RS04/RS03/RS00（可配置） | 反向（-1.0） |
| 8（夹爪） | RS00 | 位置映射：关节空间 0-0.044m 对应电机空间 0 到 -1.0472 rad |

## 依赖

- `rclcpp`
- `hardware_interface`
- `pluginlib`
- `openarmx`（CAN 驱动库）

## 前置条件

- CAN 接口已激活：`sudo ip link set can0 up type can bitrate 1000000`
- CAN-FD 模式：`sudo ip link set can0 up type can bitrate 1000000 dbitrate 5000000 fd on`
- OpenArmX 电机已上电且在 CAN 总线上有响应

## 许可证

CC-BY-NC-SA-4.0 - 成都长树机器人有限公司
