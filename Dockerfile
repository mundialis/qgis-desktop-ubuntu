FROM ubuntu:xenial
MAINTAINER Tim Cera <tim@cerazone.net>

RUN echo "deb     http://qgis.org/debian xenial main\n" >> /etc/apt/sources.list
RUN echo "deb-src http://qgis.org/debian xenial main\n" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 089EBE08314DF160
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45

RUN    apt-get -y update
RUN    apt-get -y install libgdal-dev gdal-bin qgis python-qgis qgis-plugin-grass grass 
RUN    apt-get -y install python-requests python-numpy python-pandas python-scipy python-matplotlib

# For TauDEM
RUN    apt-get -y install libopenmpi-dev
RUN    apt-get -y install build-essential g++ wget cmake

RUN    apt-get clean \
    && apt-get purge

# Download and build taudem
RUN wget -qO- https://api.github.com/repos/dtarb/TauDEM/tarball/master \
    | tar -xzC /usr/src \
    # Remove the TestSuite directory because it contains large files
    # that we don't need.
    && rm -rf /usr/src/dtarb-TauDEM-*/TestSuite \
    && cd /usr/src/dtarb-TauDEM-*/src \
    && cmake . \
    && make \
    && make clean
RUN ln -s /usr/src/dtarb-TauDEM-* /opt/taudem
ENV PATH /opt/taudem:$PATH

# Called when the Docker image is started in the container
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
