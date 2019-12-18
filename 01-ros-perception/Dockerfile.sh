
apt-get update
apt-get install -q -y tzdata dirmngr gnupg2
apt-get install -y --no-install-recommends make g++
rm -rf /var/lib/apt/lists/*

# setup keys and source.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# install bootstrap tools
apt-get update && apt-get install --no-install-recommends -y    python-rosdep     python-rosinstall   python-vcstools

rm -rf /var/lib/apt/lists/*

rosdep init
rosdep update

# install ros packages
export ROS_DISTRO=melodic
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y   ros-melodic-ros-core=1.4.1-0*    ros-melodic-perception=1.4.1-0*
rm -rf /var/lib/apt/lists/*

./ros_entrypoint.sh 

