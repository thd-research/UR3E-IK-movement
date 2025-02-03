# UR3e Cartesian Motion with ROS 2 Humble & MoveIt 2

This project enables a **UR3e robot** to move to a specified **Cartesian coordinate** with respect to the **base link** using **ROS 2 Humble, MoveIt 2, and UR Robot Drivers**.

# Installtion steps -
1. clone the repo
2. run the command `./build_docker.sh` to build the docker container
3. To go inside docker container, execute `./run_docker.sh`
4. To open another terminal inside docker `./run into_docker.sh`

# Usage -
1. Once the build is complete source the workspace using
   `source install/setup.bash `
2. To launch the UR drivers in simulation use
   `ros2 launch ur_bringup ur_control.launch.py ur_type:=ur3e use_fake_hardware:=true launch_rviz:=true robot_ip:=ip_address`
3. To launch moveit use
   `ros2 launch ur_moveit_config ur_moveit.launch.py ur_type:=ur3e robot_ip:=ROBOT_IP launch_rviz:=false`
4. Check the list of active controller using the command
   `ros2 control list_controllers`
5. Deactivate scaled_joint_trajectory_controller and reactivate joint_trajectory_controller using the commands
   `ros2 control set_controller_state scaled_joint_trajectory_controller inactive`
   `ros2 control set_controller_state joint_trajectory_controller active`
6. To move the robot to cartesian coordinate [0.3,0.2,0.3,0.0,1.0,0.0,0.0] with respect to base_link, execute `./move_robot.py` file in src folder.
   


    
