#!/bin/bash

script_dir="$( cd "$(dirname "$0")" || exit ; pwd -P )"
container_id=$(cat "${script_dir}/docker_id")

sudo_stat="y"

# If user is part of docker group, sudo isn't necessary
if groups "$USER" | grep &>/dev/null '\bdocker\b'; then
    sudo_stat="n"
fi

if [ "${container_id}" == "" ]
then
	echo "Error: No docker id found in '${script_dir}/docker_id'"
	exit 1
fi

# Check if the container is running

if [ "$sudo_stat" = "y" ]; then

    if [ "$(sudo docker ps -qf "id=${container_id}")" == "" ]
    then
    	echo "Starting as 'sudo' previously stopped container..."
    	sudo docker start "${container_id}"
    fi

    # Joining the container
    sudo docker exec -ti "${container_id}" /rosbox_entrypoint.sh
else
    if [ "$(docker ps -qf "id=${container_id}")" == "" ]
    then
    	echo "Starting previously stopped container..."
    	docker start "${container_id}"
    fi

    docker exec -ti "${container_id}" /rosbox_entrypoint.sh
fi

