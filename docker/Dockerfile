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
      vim \
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

ARG uid_arg
ARG gid_arg
ARG user_arg
ARG HOMEDIR="/home/${user_arg}"
ARG WS="${HOMEDIR}/catkin_ws"

ENV QT_X11_NO_MITSHM=1
ENV USER=${user_arg}
ENV EDITOR='vim'


RUN useradd -m $USER && \
    echo "$USER:$USER" | chpasswd && \
    usermod --shell /bin/bash $USER && \
    usermod -aG sudo,dialout $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    # Replace 1000 with your user/group id
    usermod  --uid ${uid_arg} $USER && \
    groupmod --gid ${gid_arg} $USER && \
    mkdir -p /home/$USER/catkin_ws/src && \
    chown ${uid_arg}:${gid_arg} -R /home/$USER

USER ${USER}

# https://answers.ros.org/question/10238/unable-to-contact-my-own-server/
ENV ROS_HOSTNAME=localhost
ENV ROS_MASTER_URI=http://localhost:11311

COPY bashrc ${HOMEDIR}/.bashrc
COPY bashrc /root/.bashrc
COPY bash_profile ${HOMEDIR}/.bash_profile
COPY bash_profile /root/.bash_profile
WORKDIR /home/$USER/catkin_ws

COPY rosbox_entrypoint.sh /rosbox_entrypoint.sh
ENTRYPOINT /rosbox_entrypoint.sh
