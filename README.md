# Latest QGIS 3 in docker (QGIS 3.4.x)

QGIS 3.4.x from [QGIS.org](http://qgis.org)

Included: QGIS-Processing - GRASS GIS 7.4

## Installation

Available via [mundialis docker hub repo](https://hub.docker.com/r/mundialis/docker-qgis3/):
```
docker pull mundialis/docker-qgis3
```


You can download a convenient "qgis3" startup script here: [qgis3](https://raw.githubusercontent.com/mundialis/qgis-desktop-ubuntu/master/qgis3).

Download the file and store it either into `$HOME/bin/` or in `/usr/local/bin/` (or likewise into a directory listed in your PATH environment variable) and set the "executable" flag of the script.
Hence, be sure to make the "qgis3" script an executable:
```
chmod a+x qgis3
```

## Usage

Simply run

`qgis3`

## Troubleshooting

If QGIS crashes or hangs it might leave an orphan docker process running.
If you see the process with
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


## Acknowledgements

Software: QGIS SOURCE: [ubuntugis-unstable](https://launchpad.net/~ubuntugis)

The work of [Tim Cera](https://github.com/timcera/qgis-desktop-ubuntu) and [Michael Wess](https://github.com/wessm/Dockerfiles/tree/master/qgis3) is acknowledged. Thanks!
