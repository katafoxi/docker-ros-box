ARG ros_distro
#FROM osrf/ros:${ros_distro}-desktop-full
FROM ros:noetic-ros-base
#FROM arm64v8/ros:noetic-ros-base
ARG ros_distro


SHELL ["/bin/bash", "-c"]
RUN <<EOT bash
      apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq --force-yes install \
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
      ros-$ros_distro-image-transport \
      ros-$ros_distro-image-transport-plugins \
      ros-$ros_distro-rviz \
      ros-$ros_distro-rviz-imu-plugin \
      ros-$ros_distro-serial 
      sudo pip3 install -U catkin_tools
      echo "source /opt/ros/${ros_distro}/setup.bash" >> ~/.bashrc
      source ~/.bashrc
      rm -rf /var/lib/apt/lists/* 
EOT
#rm -rf /var/lib/apt/lists/*  https://habr.com/ru/companies/flant/articles/787494/

# sudo \
# dialog \
# less \
# x-window-system \
# mesa-utils \

ARG uid
ARG gid
ARG user
ARG HOMEDIR="/home/${user}"
ARG WS="${HOMEDIR}/catkin_ws"

ENV QT_X11_NO_MITSHM=1
ENV USERNAME=${user}

RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod --shell /bin/bash $USERNAME && \
    usermod -aG sudo,dialout $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # Replace 1000 with your user/group id
    usermod  --uid ${uid} $USERNAME && \
    groupmod --gid ${gid} $USERNAME && \
    mkdir -p /home/$USERNAME/catkin_ws/src && \
    chown ${uid}:${gid} -R /home/$USERNAME

USER ${USERNAME}

# https://answers.ros.org/question/10238/unable-to-contact-my-own-server/
ENV ROS_HOSTNAME=localhost
ENV ROS_MASTER_URI=http://localhost:11311

#COPY bashrc ${HOMEDIR}/.bashrc
#COPY bashrc /root/.bashrc
#COPY bash_profile ${HOMEDIR}/.bash_profile
#COPY bash_profile /root/.bash_profile
WORKDIR /home/$USERNAME/catkin_ws

COPY rosbox_entrypoint.sh /rosbox_entrypoint.sh
ENTRYPOINT /rosbox_entrypoint.sh
