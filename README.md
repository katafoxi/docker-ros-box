# docker-ros-box

Dockerized ros desktop full with X11 support


## Credits

This project is highly inspired by [docker-browser-ros](https://github.com/sameersbn/docker-browser-box) and [this blog post from Fabio Rehm](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)


## What is does

Using this project you will be able to run a complete ROS environement inside a Docker container.

This is very handfull for example if your host operating system is *not* debian based.


## Usage

1. Download this repository and unzip it somewhere:
```
mkdir ~/my_ros_project
cd ~/my_ros_project
wget "https://github.com/pierrekilly/docker-ros-box/archive/master.zip" -O docker-ros-box.zip
unzip docker-ros-box.zip
```
2. Update your UID and GIU in `Dockerfile`
3. Run the container:
```
./start.sh
```

Once a container is run, you can connect additionnal terminals using:
```
./open.sh
```

The `src` folder is automatically mounted into `/home/developer/catkin_ws/src` so you can work there from your host system.


## Additionnal notes

- The scripts assume you run docker as root, adding `sudo` in front of them.


## Contribute

Feel free to use this project and improve it.

If you would like to contribute, clone the repository, commit your modifications and open a PR


## Author

[Pierre Killy](https://www.linkedin.com/in/pierrekilly/)


## License

MIT


