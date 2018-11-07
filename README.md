docker-qgis3-desktop-ubuntu
===========================

Instead of compiling, this image is a "apt-get install" from
http://qgis.org/ubuntugis of the latest QGIS 3.4.

This also includes installation of gdal-bin and python-gdal.

# Getting the image

## Use the docker repository:

```
docker pull mundialis/docker-qgis3
```

Required Manual Installation
----------------------------
To run a container create a shell script similar to below, perhaps called 
'qgis', but you can call it anything you want.

```
# Startup of QGIS3 in docker, see below for download of this script
#
# get user name
USER_NAME=`basename $HOME`

# MYHOME is used to pass the HOME directory of the user running qgis
# and is used in "launch_prep.sh" to create the same user within the container.

# The user home is mounted as HOME
# --rm will remove the container as soon as it ends

sudo docker run --rm --name qgis3 \
    -it \
    -v ${HOME}:/home/${USER_NAME} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -e MYHOME=${HOME} \
    mundialis/docker-qgis3
```


Note: You can download above docker startup as a convenient start script:
[qgis3](https://raw.githubusercontent.com/mundialis/qgis-desktop-ubuntu/master/qgis3).
Download it, store it into $HOME/bin/ or /usr/local/bin/ (or likewise) and
set the script to "executable":

Be sure to make the "qgis3" script (or whatever you called your script) an executable.
```
chmod a+x qgis3
```

The above is the content of qgis3 so you can just run
```
qgis3
```

The "-v ${HOME}:/home/${USER_NAME}" option will mount your home directory in
the container.  If you have other mount points, add "-v" options as necessary.

Put into a directory listed in your PATH environment variable.
```
sudo cp qgis3 /usr/local/bin
```
Note that your home directory will be mounted in the container and thus
accessible to QGIS. If you want other directories to be available, just add
then to qgis3 script with -v flags. 

If QGIS crashes or hangs it might leave an orphan docker process running. If
you see the process with 
```
docker ps
```
Then run 
```
docker stop <process id or container name>
```
Else run 
```
docker ps -a
```
then
```
docker rm <process id or container name>
```

