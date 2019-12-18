# setup timezone & install packages
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -q -y tzdata dirmngr gnupg2 python-pip
apt-get install -y --no-install-recommends make g++
apt-get install -y libusb-1.0 gtk+-3.0 build-essential libglfw3-dev
apt-get clean

rm -rf /var/lib/apt/lists/*

# setup keys and source.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# install bootstrap tools
apt-get update && apt-get install --no-install-recommends -y python-rosdep python-rosinstall python-vcstools 
apt-get clean 
rm -rf /var/lib/apt/lists/*

# setup environment
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

# bootstrap rosdep
rosdep init 
rosdep update

# install ros packages
export ROS_DISTRO=melodic
apt-get update && apt-get install -y ros-${ROS_DISTRO}-ros-core=1.4.1-0* ros-${ROS_DISTRO}-perception=1.4.1-0*    ros-${ROS_DISTRO}-rgbd-launch 
apt-get clean
rm -rf /var/lib/apt/lists/*

# setup entrypoint
#COPY ./ros_entrypoint.sh /

# installing pytorch
#WORKDIR /tmp
wget https://nvidia.box.com/shared/static/6t52xry4x2i634h1cfqvc9oaoqfzrcnq.whl -O torch-1.3.0-cp27-cp27mu-linux_aarch64.whl
pip install torch-1.3.0-cp27-cp27mu-linux_aarch64.whl torchvision
rm -rf torch-1.3.0-cp27-cp27mu-linux_aarch64.whl

# set the version of the realsense library
export LIBREALSENSE_VERSION=2.16.1

wget https://github.com/IntelRealSense/librealsense/archive/v${LIBREALSENSE_VERSION}.tar.gz
tar -xvzf v${LIBREALSENSE_VERSION}.tar.gz
rm v${LIBREALSENSE_VERSION}.tar.gz
mkdir -p librealsense-${LIBREALSENSE_VERSION}/build
cd librealsense-${LIBREALSENSE_VERSION}/build
cmake .. 
make
make install
rm -rf librealsense-${LIBREALSENSE_VERSION}

bash ./ros_entrypoint.sh
