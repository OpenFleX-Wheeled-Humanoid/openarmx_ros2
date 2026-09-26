#!/bin/bash

# Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
#
# Copyright (c) 2026 Chengdu Changshu Robot Co., Ltd.
# https://www.openarmx.com
#
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike
# 4.0 International License (CC BY-NC-SA 4.0).
# To view a copy of this license, visit:
#
# http://creativecommons.org/licenses/by-nc-sa/4.0/
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

# OpenArmX Bimanual MoveIt Demo - Simulation Mode
# This script launches the MoveIt demo in simulation mode without hardware dependencies

set -e  # Exit on any error

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORKSPACE_ROOT="${OPENFLEX_WORKSPACE:-}"
if [ -z "$WORKSPACE_ROOT" ]; then
    candidate="$SCRIPT_DIR"
    while [ "$candidate" != "/" ]; do
        if [ -d "$candidate/src" ] && [ -f "$candidate/install/setup.bash" ]; then
            WORKSPACE_ROOT="$candidate"
            break
        fi
        candidate="$(dirname "$candidate")"
    done
fi

echo "=========================================="
echo "  OpenArmX Bimanual MoveIt - Simulation"
echo "=========================================="
echo ""
echo "Script directory: $SCRIPT_DIR"
echo "Workspace root: $WORKSPACE_ROOT"
echo ""

# Source the workspace chain, which includes its matching Humble or Jazzy underlay.
if [ -z "$WORKSPACE_ROOT" ] || [ ! -f "$WORKSPACE_ROOT/install/setup.bash" ]; then
    echo "✗ Error: OpenFlex workspace setup not found. Build the workspace or set OPENFLEX_WORKSPACE."
    exit 1
fi
WORKSPACE_ROOT="$(cd "$WORKSPACE_ROOT" && pwd)"
echo "Sourcing ROS 2 workspace: $WORKSPACE_ROOT"
source "$WORKSPACE_ROOT/install/setup.bash"
echo "✓ ROS 2 ${ROS_DISTRO:-} environment sourced"

echo ""
echo "Starting MoveIt demo in SIMULATION mode..."
echo "  - No hardware required"
echo "  - No CAN interfaces needed"
echo "  - Fake hardware controllers will be used"
echo ""
echo "Launch command: ros2 launch openarmx_bimanual_moveit_config demo_sim.launch.py"
echo ""

# Check if package exists
if ros2 pkg prefix openarmx_bimanual_moveit_config &>/dev/null; then
    echo "✓ Package openarmx_bimanual_moveit_config found"
    # Launch MoveIt demo in simulation mode
    ros2 launch openarmx_bimanual_moveit_config demo_sim.launch.py
else
    echo "✗ Error: Package 'openarmx_bimanual_moveit_config' not found"
    echo "  Available packages:"
    ros2 pkg list 2>/dev/null | grep openarmx || echo "  No openarmx packages found"
    exit 1
fi
