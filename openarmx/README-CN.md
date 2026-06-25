# openarmx（元包）

[English](./README.md) | 中文

---

ROS 2 元包，聚合 OpenArmX 核心功能包，便于统一安装和依赖管理。

## 概述

本包是一个元包，不包含自身代码。它声明了对 OpenArmX 核心包的依赖，安装 `openarmx` 即可拉取运行机器人所需的全部基础包。

## 包含的功能包

| 功能包 | 描述 |
|--------|------|
| `openarmx_bringup` | 双臂机器人的启动文件 |
| `openarmx_description` | URDF/Xacro 机器人模型和网格文件 |
| `openarmx_hardware` | OpenArmX 电机的 ros2_control 硬件接口 |

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx
source install/setup.bash
```

### 安装所有核心包

编译此元包可确保所有核心运行时依赖可用：

```bash
colcon build --packages-up-to openarmx
```

## 许可证

CC-BY-NC-SA-4.0 - 成都长树机器人有限公司
