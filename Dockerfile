# Start with Ubuntu 22.04 base image
FROM ubuntu:22.04

LABEL maintainer="Vinayak Samant <vinayakvsamant@gmail.com>"

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

ENV ROS_DISTRO=humble

# Install utility packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3 \
        python3-pip \
        wget \
        nano \
        gedit \
        cmake \
        git \
        curl \
        locales \
        software-properties-common \
        lsb-release && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

# Network based communication
RUN apt-get update && apt-get install -y \
    iputils-ping \
    net-tools \
    dnsutils \
    curl \
    wget \
    tcpdump \
    telnet \
    traceroute \
    iproute2


# Enable Universe repository
RUN add-apt-repository universe

# Add ROS 2 GPG key and repository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | \
    tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS 2 Humble Desktop and other dependencies
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    ros-humble-gazebo-ros-pkgs && \
    rm -rf /var/lib/apt/lists/*

# Source ROS 2 setup and update environment
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

#### Moveit2 installation
# Install python3-rosdep if not already installed
RUN apt-get update && apt-get install -y python3-rosdep

RUN apt update && apt install -y ros-humble-ros2-control ros-humble-ros2controlcli


# Install vcstool for managing source code
RUN apt-get install -y python3-vcstool

# Initialize and update rosdep for dependency resolution
RUN rosdep init && rosdep update 

RUN apt update && apt dist-upgrade -y

# Install Colcon extensions for building ROS 2 workspaces
RUN apt-get update && apt-get install -y python3-colcon-common-extensions 

RUN apt-get update && apt-get install -y python3-colcon-mixin 

RUN colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update default
  

# UR drivers
RUN apt-get install ros-humble-ur -y

# Copy the workspace
COPY ros2_ws /ros2_ws 
   
WORKDIR /ros2_ws/src
RUN rosdep update && \
    rosdep install -r --from-paths . --ignore-src --rosdistro Humble -y

WORKDIR /ros2_ws
#RUN colcon build 

## GUI tunnel from docker
RUN dpkg --add-architecture i386 && \
apt-get update && apt-get install -y --no-install-recommends \
    libxau6 libxau6:i386 \
    libxdmcp6 libxdmcp6:i386 \
    libxcb1 libxcb1:i386 \
    libxext6 libxext6:i386 \
    libx11-6 libx11-6:i386 && \
rm -rf /var/lib/apt/lists/*

# Source ROS 2 setup and update environment
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Set up entrypoint to source ROS 2 environment
ENTRYPOINT ["bash", "-c", "source /opt/ros/humble/setup.bash && exec bash"]
