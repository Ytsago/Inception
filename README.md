This project has been created as part of the 42 curriculum by secros

# Inception

### Description
Inception is a project of 42 school, it involved creating a website using a dockerized environment.
Each services has to run in their own container and must communicate to other via a private network.
### Instruction
To use this project :
- Be sure to have docker installed.
- Also you'ill need sudo right to operate it.

There is a Makefile in the root directory with following command :
- make 
*Create the docker images or recreate it if they already exists. Also create the volumes, network and containers if they didn't exists and start them*
- make **up**
>*Same as make but do not recreate the images.*
- make **down**
>*Stop the containers and destroy them*
- make **stop**
>*Only stop containers. Prefer this over recreating every time*
- make **status**
>*Display information about images and container*
- make **clear_vol**
>*Remove only the volumes*
- make **clear**
>*Remove volumes, containers, images and clear cache*
- make **re**
>*same as using ***make clear*** and ***make***

# Project Description

### Docker
**Virtual Machine** recreate a working operating system, a part of the hardware is visualize so the **VM** can use it. It act as a completely independent computer.

**Docker** is a minimalist working environment. It use is own file-system and the container use directly the kernel resources.

The main difference between docker and virtual machine reside in their use:
- Virtual machine is used to recreate a whole operating system on any hardware
>*They are isolated and take a fixed amount of resources*
- Docker is used to run an application or a services on any operating system 
>*They are easy to deploy, expandable and can easily communicate with one other*

### Private Information
Docker rely on two methods to incorporate private information into the container, **Secret** and **Environment Variables**

**Secret** are data such as password or certificate that should not be transmitted over a network or stored unencrypted in a dockerfile or in the application source code. They are stored in a virtual file-system manager and transmitted only to the application who have been granted access to them.

**Environment Variables** in the other and are visible to anyone with access to the container, including processes running within the container. They are stored in a *.env* in the parent file-system and transmit by the docker-compose file.

### Network
**Host Network** correspond to the machine network. It permit communication between your machine and others machines or services. When a service connect to an external resources (like internet) it is via the host network. Your machine environment is on the host network. You have to authorized access to port so external devices can communicate with you.

**Docker Network** in the same manner as the **Host network** permit communication between services except that it is restricted to the docker environment. Only the docker sharing the same network can communicate with one other. A server listening on the docker network isn't available outside the containers.
>*For expample, in this project a lot of services communicate with one other through the docker network such as nginx, wordpress, mariadb... But only nginx is available outside because his port is forwarded in the dockerfile and bind to an Host network port in the docker-compose*

### Volumes
**Bind mounts** is when a file or directory on the host system is "mounted" (rendering accessible) into a container. It rely on the host machine operating system and directory structure.

**Docker Volumes** is the recommended method for storing data created and utilized by Docker containers. It is entirely handle by Docker so it is the perfect solution for heterogeneous system.
In the back the volumes is simply a folder stored by default in /var/lib/docker/volumes. with docker volumes you can use docker command such as *Docker volume ls*

For this project two volume were ask by the subject i choose to bind physically existing folders on the machine by specifying where the volume are stored in the docker-compose. They are respectively located in */var/www/html/*

### Ressources

for **Docker**:
https://docs.docker.com/

for **Nginx**:
https://nginx.org/en/docs/
https://developer.wordpress.org/advanced-administration/server/web-server/nginx/

for **Wordpress**:
https://wp-cli.org/
https://developer.wordpress.org/advanced-administration/

for **Redis**
https://redis.io/docs/latest/operate/oss_and_stack/

for **vsFTPD**
https://documentation.ubuntu.com/server/how-to/networking/ftp/
https://guide.ubuntu-fr.org/server/ftp-server.html
