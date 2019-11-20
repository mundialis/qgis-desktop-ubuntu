FROM ubuntu:bionic

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Dockerfile inspired by
#   https://github.com/timcera/qgis-desktop-ubuntu
#
# Instead of compiling, this image is a "apt-get install" from
# http://qgis.org/ubuntugis of the latest QGIS 3.4.

LABEL maintainer="Markus Neteler <neteler@mundialis.de>"


ENV TZ Europe/Berlin

# Need to have apt-transport-https in-place before drawing from
# https://qgis.org
RUN    echo $TZ > /etc/timezone                                              \
    && apt-get -y update                                                     \
    && apt-get -y install --no-install-recommends tzdata                     \
                                                  dirmngr gpg-agent          \
                                                  apt-transport-https        \
                                                  software-properties-common \
    && add-apt-repository ppa:ubuntugis/ubuntugis-unstable                   \
    && rm /etc/localtime                                                     \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime                        \
    && dpkg-reconfigure -f noninteractive tzdata                             \
    && apt-get clean                                                         \
    && apt-get purge                                                         \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN    echo "deb     https://qgis.org/ubuntugis bionic main" >> /etc/apt/sources.list
RUN    echo "deb-src https://qgis.org/ubuntugis bionic main" >> /etc/apt/sources.list

# Key for qgis ubuntugis
RUN    apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45

RUN    apt-get -y update                                                  \
    && apt-get -y install --no-install-recommends                         \
                                                  python3-requests         \
                                                  python3-numpy            \
                                                  python3-pandas           \
                                                  python3-scipy            \
                                                  python3-matplotlib       \
                                                  python3-pyside.qtwebkit  \
                                                  gdal-bin                \
                                                  qgis                    \
                                                  qgis-provider-grass     \
                                                  grass                   \
    && apt-get clean                                                      \
    && apt-get purge                                                      \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Called when the Docker image is started in the container

ADD launch_prep.sh /launch_prep.sh
RUN chmod +x /launch_prep.sh
CMD ["/launch_prep.sh"]
