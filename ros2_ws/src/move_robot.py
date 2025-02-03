#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
from moveit_msgs.srv import GetPositionIK
from geometry_msgs.msg import PoseStamped
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import time


class MoveURRobot(Node):
    def __init__(self):
        super().__init__('move_ur_robot_node')
        
        self.ik_client = self.create_client(GetPositionIK, 'compute_ik') 
        self.ik_client.wait_for_service() 

        self.trajectory_publisher = self.create_publisher(
            JointTrajectory, 
            '/joint_trajectory_controller/joint_trajectory', 
            10
        ) # creating publisher ffor publishing joint values
        self.joint_state_subscriber = self.create_subscription(
            JointState, 
            '/joint_states', 
            self.joint_state_callback, 
            10)  #subsrciber for joint states

        self.joint_state = None

        self.get_logger().info("MoveURRobot node has been initialized")

    def joint_state_callback(self, msg): 
        self.joint_state = msg

    def move_to_pose(self, target_pose, duration_s=10): 

        while self.joint_state is None:
            rclpy.spin_once(self)
        
        _time_measure = time.time_ns()
        # Request for the compute_ik service
        ik_request = GetPositionIK.Request()
        ik_request.ik_request.group_name = 'ur_manipulator'  
        ik_request.ik_request.robot_state.joint_state.name = self.joint_state.name  
        ik_request.ik_request.robot_state.joint_state.position = self.joint_state.position
        ik_request.ik_request.pose_stamped = target_pose
        ik_request.ik_request.timeout.sec = 2

        future = self.ik_client.call_async(ik_request)  # Call the service and wait for the response
        rclpy.spin_until_future_complete(self, future)
        
        response = future.result()
        if response.error_code.val == response.error_code.SUCCESS:
            self.get_logger().info("Inverse kinematics solution found")
            # self.get_logger().info(f"Joint positions: {response.solution.joint_state.position}")
            
            # Publish the trajectory to move the robot
            trajectory_msg = JointTrajectory()
            trajectory_msg.joint_names = response.solution.joint_state.name
            
            point = JointTrajectoryPoint()
            point.positions = response.solution.joint_state.position
            point.time_from_start.sec = duration_s # Time to reach the target position
            
            trajectory_msg.points.append(point)
            
            # Publish the trajectory message
            self.trajectory_publisher.publish(trajectory_msg)
            self.get_logger().info("Trajectory published to move the robot")
        else:
            self.get_logger().warn("Failed to find an inverse kinematics solution")

        print("Take {} ns".format(time.time_ns() - _time_measure))
        print("trajectory_msg.points len:", len(trajectory_msg.points), trajectory_msg.points)
        print("response:", response)


def main(args=None):
    rclpy.init(args=args)

    node = MoveURRobot()

    # target pose
    target_pose = PoseStamped()
    target_pose.header.frame_id = 'base_link'
    target_pose.pose.position.x = 0.3
    target_pose.pose.position.y = 0.3
    target_pose.pose.position.z = 0.3
    target_pose.pose.orientation.w = 0.0
    target_pose.pose.orientation.x = 1.0
    target_pose.pose.orientation.y = 0.0
    target_pose.pose.orientation.z = 0.0
 
    node.move_to_pose(target_pose)

    time.sleep(2)
    target_pose.pose.position.x = 0.0
    node.move_to_pose(target_pose, duration_s=5)
    
    time.sleep(1)
    target_pose.pose.position.x = 0.3
    node.move_to_pose(target_pose, duration_s=5)

    rclpy.shutdown()

if __name__ == '__main__':
    main()
