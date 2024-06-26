# PHP/APACHE/MARIADB LAMP STACK DOCKER TEMPLATE #

This is a docker container for hosting a traditional LAMP stack based system. It is not intended for hosting WordPress websites.

### The Stack ###
* Apache
* Maria DB MySQL
* PHP 8.1.9
* ClamAV Antivirus

### Please note ###

This repo is intended for development directly onto a live development server using an SFTP plugin to auto upload file changes on save.

### Usage ###

* Simply put your project files in the **/www/** folder.
* The **/temp/** folder is intended for temporary files and virus scanning before processing. This is mapped to an isolated docker volume.
* The **/uploads/** folder is self-explanatory, and again mapped to a docker volume.

Docker volumes can be found at **/var/lib/docker/volumes/** on linux based systems like our servers, but please be careful if you manually add files here, as you will need to use the CLI to enter your container's environment to correct file permissions. 

### Set up ###

**Key differences between dev and live are:**

* Error logging and error display messages are enabled for development environments and disabled for production. 
* Memory limits are higher for production environments for better performance.
* PHP opcache is set to not revalidate on production environments meaning a container rebuild is required to see code changes, this is to improve performance on production. On development environments you are able to make changes inside the /www/ directory and see them straight away on refresh without a container rebuild.

**Edit the .env and dev.env files and update the variables to suit your project.**

* COMPOSE_PROJECT_NAME:**[git repo name]**

* HOST_SERVER_IP:**[Set both the development and production server's IP address, this is vital for using this container's antivirus.]**
* HOST_NAME=**[project's production domain]**
* HOST_CONTAINER_NAME=**[git repo name]**
* HOST_CONTAINER_IMAGE=php:**[git repo name]**
* HOST_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

* DB_CONTAINER_NAME=**[git repo name]**-db
* DB_CONTAINER_IMAGE=mariadb:**[git repo name]**-db
* DB_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

* DBADMIN_CONTAINER_NAME=**[git repo name]**-dbadmin
* DBDBADMIN_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

* AV_CONTAINER_NAME=lamp-**[git repo name]**-clamav
* AV_CONTAINER_IMAGE=clamav/clamav:**[git repo name]**
* AV_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

* MYSQL_DATABASE=**[ Assign database name ]**
* MYSQL_USER=**[ Assign database user ]**
* MYSQL_PASSWORD=**[ Assign database password, please use a password at least 16 characters in length ]**

### Handling uploads and virus scanning ###

The OS level antivirus doesn't catch threats in realtime when within a docker container, but it does catch them on a general system scan. This means that we need to pass uploads through a dedicated antivirus scanner to achieve that real-time behavior for new uploads.

Also, the antivirus child container doesn't have access to the PHP child container's OS level file system, meaning it can't see the directory where new uploads arrive. So with this repo, we share the PHP volume with the antivirus, so it is recommended to move uploads to the **/temp/** folder on upload, and then run the antivirus scan on that file.

### Adding new environment variables ###

New environment variables need to be added to 4 files in order to be available via PHP.

1. Update the dev.env file
2. Update the .env file
3. update the docker-compose.yml file
4. update the ./.docker/host/Dockerfile file

After adding new variables, the docker container will need to be rebuilt

Also note, there is a weird bug now and again, where docker won't honor the last environment variable added to the Dockerfile, to prevent this bug make sure "SetEnv DOCKER_BUG ${DOCKER_BUG}" is the last one in that file.

### Server side install ###

Via the command line, goto the root directory of the repo and use the command **"sh tools.sh"** to build or rebuild the docker container, this will also update the environment and rebuild the React App.

### Nginx reverse proxy, SSL and DNS setup ###

This docker container was intended to be used on shared hosting via Nginx Reverse proxy. Use Nginx to handle SSL and DNS pointing to the container's assigned port number