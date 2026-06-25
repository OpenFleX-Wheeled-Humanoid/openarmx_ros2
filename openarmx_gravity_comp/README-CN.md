# openarmx_gravity_comp

[English](./README.md) | 中文

---

基于 KDL 动力学的 OpenArmX 双臂重力补偿前馈节点。

## 概述

本包为 OpenArmX 双臂机器人实时计算重力力矩，并发布到前馈力矩控制器。使用 Orocos KDL 库，根据 `/joint_states` 的当前关节位置求解仅含重力项的逆动力学。

## 工作原理

1. 加载 URDF 并为左右臂构建 KDL 运动链（从 `openarmx_left_link0` 到 `openarmx_left_link7`，右臂类似）
2. 订阅 `/joint_states` 获取当前关节位置
3. 使用 KDL 逆动力学计算重力力矩，重力向量按各臂基座坐标系旋转
4. 按可配置的 `g_scale` 因子缩放力矩
5. 按关节安全限值钳位力矩（关节 1-2: 20 Nm，关节 3-4: 7 Nm，关节 5-7: 2 Nm）
6. 将力矩指令发布到力矩控制器

## 使用方法

### 编译

```bash
cd ~/openflex_ws
colcon build --packages-select openarmx_gravity_comp
source install/setup.bash
```

### 单独运行

```bash
ros2 run openarmx_gravity_comp gravity_comp_node --ros-args \
  -p urdf_path:=/tmp/v10_bimanual_gravity.urdf \
  -p g_scale:=1.05 \
  -p enable_left:=true \
  -p enable_right:=true
```

### 典型用法（通过 bringup 启动）

重力补偿节点通常由 `openarmx_bringup` 或 `openarmx_preview_bringup` 在 `enable_forward_effort:=true` 时自动启动：

```bash
ros2 launch openarmx_bringup openarmx.bimanual.launch.py enable_forward_effort:=true
```

## 参数

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `urdf_path` | ``（必需） | 用于 KDL 链构建的 URDF 文件路径 |
| `g_scale` | `1.05` | 重力力矩缩放因子（可运行时调整） |
| `enable_left` | `true` | 启用左臂补偿 |
| `enable_right` | `true` | 启用右臂补偿 |
| `verbose` | `false` | 打印逐关节力矩调试信息 |

## 话题

### 订阅

| 话题 | 类型 | 描述 |
|------|------|------|
| `/joint_states` | `sensor_msgs/JointState` | 当前关节位置 |

### 发布

| 话题 | 类型 | 描述 |
|------|------|------|
| `/left_forward_effort_controller/commands` | `std_msgs/Float64MultiArray` | 左臂重力力矩（7个值） |
| `/right_forward_effort_controller/commands` | `std_msgs/Float64MultiArray` | 右臂重力力矩（7个值） |

## 依赖

- `rclcpp`、`sensor_msgs`、`std_msgs`
- `orocos_kdl`、`kdl_parser`
- `urdf`、`urdfdom`、`urdfdom_headers`
- `Eigen3`

## 注意事项

- 重力向量根据安装方向按臂配置（右臂: gy=-9.81，左臂: gy=+9.81）
- 方向修正由硬件接口 write() 处理，本节点不处理
- `g_scale` 参数可通过 `ros2 param set` 在运行时调整

## 许可证

CC-BY-NC-SA-4.0 - 成都长树机器人有限公司
