FROM nvcr.io/nvidia/l4t-base:r32.2

MAINTAINER benson

# setup timezone & install packages
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y tzdata dirmngr gnupg2 python-pip && \
    apt-get install -y --no-install-recommends make g++ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# setup keys and source.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO melodic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \ 
    ros-melodic-ros-core=1.4.1-0* \
    ros-melodic-perception=1.4.1-0* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

# installing pytorch
WORKDIR /tmp
RUN wget https://nvidia.box.com/shared/static/6t52xry4x2i634h1cfqvc9oaoqfzrcnq.whl -O torch-1.3.0-cp27-cp27mu-linux_aarch64.whl && \
    pip install torch-1.3.0-cp27-cp27mu-linux_aarch64.whl && \
    rm -rf torch-1.3.0-cp27-cp27mu-linux_aarch64.whl

# installing realsense
RUN git clone https://github.com/biomotion/installLibrealsense.git
WORKDIR /tmp/installLibrealsense
RUN ./installLibrealsense.sh


ENTRYPOINT ["/ros_entrypoint.sh"]
WORKDIR /
CMD ["bash"]
