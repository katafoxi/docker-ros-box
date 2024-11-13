ARG ros_distro
ARG uid
ARG gid
#FROM osrf/ros:${ros_distro}-desktop-full
FROM ros:noetic-ros-base
#FROM arm64v8/ros:noetic-ros-base

ARG ros_distro
ARG uid
ARG gid

RUN <<EOT bash
      apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq --force-yes install \
	  sudo \
	  dialog \
	  less \
	  x-window-system \
	  mesa-utils \
      git \
      pip \
      wget \
      freeglut3-dev \
      libglew-dev \
      libxkbcommon0 \
      libxkbcommon-x11-0 \
      libyaml-cpp-dev \
      python3-psutil \
      python3-rosdep \
      ros-$ros_distro-rviz \
      ros-$ros_distro-image-transport \
      ros-$ros_distro-image-transport-plugins 
      sudo pip3 install -U catkin_tools
      rosdep init
      catkin init
      echo "source /opt/ros/${ros_distro}/setup.bash" >> ~/.bashrc
      source ~/.bashrc

EOT

RUN mkdir -p /home/${ros_distro}-dev/catkin_ws/src && \
    echo "${ros_distro}-dev:x:${uid}:${gid}:Developer,,,:/home/${ros_distro}-dev:/bin/bash" >> /etc/passwd && \
    echo "${ros_distro}-dev:x:${gid}:" >> /etc/group && \
    echo "${ros_distro}-dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${ros_distro}-dev && \
    chmod 0440 /etc/sudoers.d/${ros_distro}-dev && \
    chown ${uid}:${gid} -R /home/${ros_distro}-dev

USER ${ros_distro}-dev
ENV HOME /home/${ros_distro}-dev
COPY bashrc /home/${ros_distro}-dev/.bashrc
COPY bashrc /root/.bashrc
COPY bash_profile /home/${ros_distro}-dev/.bash_profile
COPY bash_profile /root/.bash_profile

COPY rosbox_entrypoint.sh /rosbox_entrypoint.sh
ENTRYPOINT /rosbox_entrypoint.sh
