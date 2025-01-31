# CMake generated Testfile for 
# Source directory: /ros2_ws/src/moveit2/moveit_core/distance_field
# Build directory: /ros2_ws/build/moveit_core/distance_field
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[test_voxel_grid]=] "/usr/bin/python3" "-u" "/opt/ros/humble/share/ament_cmake_test/cmake/run_test.py" "/ros2_ws/build/moveit_core/test_results/moveit_core/test_voxel_grid.gtest.xml" "--package-name" "moveit_core" "--output-file" "/ros2_ws/build/moveit_core/ament_cmake_gtest/test_voxel_grid.txt" "--command" "/ros2_ws/build/moveit_core/distance_field/test_voxel_grid" "--gtest_output=xml:/ros2_ws/build/moveit_core/test_results/moveit_core/test_voxel_grid.gtest.xml")
set_tests_properties([=[test_voxel_grid]=] PROPERTIES  LABELS "gtest" REQUIRED_FILES "/ros2_ws/build/moveit_core/distance_field/test_voxel_grid" TIMEOUT "60" WORKING_DIRECTORY "/ros2_ws/build/moveit_core/distance_field" _BACKTRACE_TRIPLES "/opt/ros/humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/opt/ros/humble/share/ament_cmake_gtest/cmake/ament_add_gtest_test.cmake;86;ament_add_test;/opt/ros/humble/share/ament_cmake_gtest/cmake/ament_add_gtest.cmake;93;ament_add_gtest_test;/ros2_ws/src/moveit2/moveit_core/distance_field/CMakeLists.txt;25;ament_add_gtest;/ros2_ws/src/moveit2/moveit_core/distance_field/CMakeLists.txt;0;")
add_test([=[test_distance_field]=] "/usr/bin/python3" "-u" "/opt/ros/humble/share/ament_cmake_test/cmake/run_test.py" "/ros2_ws/build/moveit_core/test_results/moveit_core/test_distance_field.gtest.xml" "--package-name" "moveit_core" "--output-file" "/ros2_ws/build/moveit_core/ament_cmake_gtest/test_distance_field.txt" "--command" "/ros2_ws/build/moveit_core/distance_field/test_distance_field" "--gtest_output=xml:/ros2_ws/build/moveit_core/test_results/moveit_core/test_distance_field.gtest.xml")
set_tests_properties([=[test_distance_field]=] PROPERTIES  LABELS "gtest" REQUIRED_FILES "/ros2_ws/build/moveit_core/distance_field/test_distance_field" TIMEOUT "60" WORKING_DIRECTORY "/ros2_ws/build/moveit_core/distance_field" _BACKTRACE_TRIPLES "/opt/ros/humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/opt/ros/humble/share/ament_cmake_gtest/cmake/ament_add_gtest_test.cmake;86;ament_add_test;/opt/ros/humble/share/ament_cmake_gtest/cmake/ament_add_gtest.cmake;93;ament_add_gtest_test;/ros2_ws/src/moveit2/moveit_core/distance_field/CMakeLists.txt;28;ament_add_gtest;/ros2_ws/src/moveit2/moveit_core/distance_field/CMakeLists.txt;0;")
