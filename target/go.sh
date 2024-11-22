#!/bin/bash
echo "Hello"
script_dir="$( cd "$(dirname "$0")" || exit ; pwd -P )"
container_id=$(cat "${script_dir}/docker_id")

sudo_stat="sudo"

# If user is part of docker group, sudo isn't necessary
if groups "$USER" | grep &>/dev/null '\bdocker\b'; then
    sudo_stat=""
fi

if [ "${container_id}" == "" ]
then
	echo "Error: No docker id found in '${script_dir}/docker_id'"
	exit 1
fi

# update file with token privileges to access X11 server
XAUTHDIR=/tmp/.X11_to_docker.xauth
echo "$ DISPLAY = $DISPLAY"
XAUTH=${XAUTHDIR}/.docker.xauth
if [ -e $XAUTHDIR ]; then 
    sudo rm -rf $XAUTHDIR
    echo "remove $XAUTHDIR"
fi

mkdir -p $XAUTHDIR
echo "mkdir to $XAUTHDIR"
touch $XAUTH
echo "Create new XAUTH token file $XAUTH"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 755 $XAUTH
echo


# Check if the container is running
if [ "$( $sudo_stat docker ps -qf "id=${container_id}")" == "" ]
then
    echo "Starting as 'sudo' previously stopped container..."
    $sudo_stat docker start "${container_id}"
fi

# Joining the container
$sudo_stat docker exec -e DISPLAY=$DISPLAY -ti "${container_id}" /rosbox_entrypoint.sh


echo "Stopped container with id = ${container_id}"
docker stop "${container_id}"

