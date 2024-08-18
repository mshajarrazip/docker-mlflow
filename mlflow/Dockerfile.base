
FROM ubuntu:20.04
ENV TZ="Asia/Kuala_Lumpur"
################################################################################
#
#   Ubuntu 20.04, python3.10, pyodbc
#
################################################################################

SHELL ["/bin/bash", "-c"]

# apt update
RUN apt update && apt upgrade -y

# install python 3.10
RUN apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install -y python3.10 && \
    apt-get install -y \
    python3-pip python3.10-dev python3.10-distutils python3.10-venv && \
    cd /usr/local/bin && \
    ln -s /usr/bin/python3.10 python

    
# pyodbc prereqs + mssql odbc driver
RUN apt-get update && \
    apt-get install -y curl 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > \
        /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    apt-get install -y unixodbc unixodbc-dev libpq-dev
    

RUN apt clean \
    apt-get clean