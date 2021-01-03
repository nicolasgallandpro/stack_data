FROM ubuntu:20.04

ENV Z_VERSION="0.9.0"

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    Z_HOME="/zeppelin" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    ZEPPELIN_ADDR="0.0.0.0"

RUN echo "$LOG_TAG update and install basic packages" && \
    apt-get -y update && \
    apt-get install -y locales && \
    locale-gen $LANG && \
    apt-get install -y software-properties-common && \
    apt -y autoclean && \
    apt -y dist-upgrade && \
    apt-get install -y build-essential

RUN echo "$LOG_TAG install tini related packages" && \
    apt-get install -y wget curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN echo "$LOG_TAG Install java8" && \
    apt-get -y update && \
    apt-get install -y openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/*

#python 3.7
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.7 -y
#RUN rm /usr/bin/python
#RUN ln /usr/bin/python3.7 /usr/bin/python
#--
RUN echo "$LOG_TAG Install miniconda3 related packages" && \
    apt-get -y update && \
    apt-get install -y bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git

#RUN apt install python-is-python3 -y

RUN echo "$LOG_TAG Install python related packages" && \
    apt-get -y update && \
    apt-get install -y python3-pip && \
    apt-get install -y gfortran && \
    # numerical/algebra packages
    #pip3 install -q pycodestyle && \
    python3.7 -m pip install -q numpy pandas scipy bkzep pandasql ipython matplotlib bokeh seaborn

RUN echo "$LOG_TAG Cleanup" && \
    apt-get autoclean && \
    apt-get clean

RUN echo "$LOG_TAG Download Zeppelin binary" && \
    wget --quiet -O /tmp/zeppelin-${Z_VERSION}-bin-all.tgz http://archive.apache.org/dist/zeppelin/zeppelin-${Z_VERSION}/zeppelin-${Z_VERSION}-bin-all.t
gz && \
    tar -zxvf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz && \
    rm -rf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz && \
    mkdir -p ${Z_HOME} && \
    mv /zeppelin-${Z_VERSION}-bin-all/* ${Z_HOME}/ && \
    chown -R root:root ${Z_HOME} && \
    mkdir -p ${Z_HOME}/logs ${Z_HOME}/run ${Z_HOME}/webapps && \
    # Allow process to edit /etc/passwd, to create a user entry for zeppelin
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    # Give access to some specific folders
    chmod -R 775 "${Z_HOME}/logs" "${Z_HOME}/run" "${Z_HOME}/notebook" "${Z_HOME}/conf" && \
    # Allow process to create new folders (e.g. webapps)
    chmod 775 ${Z_HOME}

#COPY log4j.properties ${Z_HOME}/conf/
#COPY log4j_docker.properties ${Z_HOME}/conf/

#RUN rm /usr/bin/python
RUN ln /usr/bin/python3.7 /usr/bin/python

USER 1000

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]
