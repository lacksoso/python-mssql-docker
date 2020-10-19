FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --fix-missing
RUN apt-get -y install locales
RUN locale-gen "C.UTF-8"
RUN dpkg-reconfigure locales
ENV LANG "C.UTF-8"
ENV LC_ALL "C.UTF-8"
RUN update-locale LANG="C.UTF-8"
RUN apt-get update
RUN apt-get -y install \
    gcc \
    make \
    zlib1g-dev \
    wget \
    openssl \
    libssl-dev \
    libsqlite3-dev \
    curl \
    gnupg2 \
    apt-transport-https

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get -y install msodbcsql17
RUN apt-get -y install unixodbc-dev

RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
RUN tar xvf Python-3.9.0.tgz
RUN wget https://bootstrap.pypa.io/get-pip.py

RUN apt-get -y install \
    python3-dev \
    build-essential \
    libffi-dev

RUN cd Python-3.9.0 && ./configure --enable-optimizations --without-tests && make -j8 build_all && make altinstall
RUN python3.9 get-pip.py

