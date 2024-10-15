#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import sys
import IPython
import signal
from interbotix_xs_modules.arm import InterbotixManipulatorXS
from interbotix_xs_msgs.msg import JointSingleCommand
from constants import MASTER2PUPPET_JOINT_FN, DT, START_ARM_POSE, MASTER_GRIPPER_JOINT_MID, PUPPET_GRIPPER_JOINT_CLOSE
from robot_utils import torque_on, torque_off, move_arms, move_grippers, get_arm_gripper_positions

e = IPython.embed

def prep_robots(master_bot, puppet_bot):
    puppet_bot.dxl.robot_reboot_motors("single", "gripper", True)
    puppet_bot.dxl.robot_set_operating_modes("group", "arm", "position")
    puppet_bot.dxl.robot_set_operating_modes("single", "gripper", "current_based_position")
    master_bot.dxl.robot_set_operating_modes("group", "arm", "position")
    master_bot.dxl.robot_set_operating_modes("single", "gripper", "position")
    torque_on(puppet_bot)
    torque_on(master_bot)
    start_arm_qpos = START_ARM_POSE[:6]
    move_arms([master_bot, puppet_bot], [start_arm_qpos] * 2, move_time=1)
    move_grippers([master_bot, puppet_bot], [MASTER_GRIPPER_JOINT_MID, PUPPET_GRIPPER_JOINT_CLOSE], move_time=0.5)

def press_to_start(master_bot):
    master_bot.dxl.robot_torque_enable("single", "gripper", False)
    print(f'Close the gripper to start')
    close_thresh = -0.1
    pressed = False
    while not pressed:
        gripper_pos = get_arm_gripper_positions(master_bot)
        if gripper_pos < close_thresh:
            pressed = True
        time.sleep(DT/10)
    torque_off(master_bot)
    print(f'Started!')

def teleop(robot_side):
    puppet_bot = InterbotixManipulatorXS(robot_model="vx300s", group_name="arm", gripper_name="gripper", robot_name=f'puppet_{robot_side}', init_node=True)
    master_bot = InterbotixManipulatorXS(robot_model="wx250s", group_name="arm", gripper_name="gripper", robot_name=f'master_{robot_side}', init_node=False)
    prep_robots(master_bot, puppet_bot)
    press_to_start(master_bot)

    gripper_command = JointSingleCommand(name="gripper")

    def signal_handler(sig, frame):
        print("\nCtrl+C pressed. Exiting gracefully...")
        puppet_bot.dxl.robot_torque_enable("group", "all", False)
        master_bot.dxl.robot_torque_enable("group", "all", False)
        sys.exit(0)

    # Register signal handler for Ctrl+C
    signal.signal(signal.SIGINT, signal_handler)

    try:
        while True:
            master_state_joints = master_bot.dxl.joint_states.position[:6]
            puppet_bot.arm.set_joint_positions(master_state_joints, blocking=False)
            master_gripper_joint = master_bot.dxl.joint_states.position[6]
            puppet_gripper_joint_target = MASTER2PUPPET_JOINT_FN(master_gripper_joint)
            gripper_command.cmd = puppet_gripper_joint_target
            puppet_bot.gripper.core.pub_single.publish(gripper_command)
            time.sleep(DT)
    except KeyboardInterrupt:
        signal_handler(None, None)

if __name__ == '__main__':
    teleop("right")
