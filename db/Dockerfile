# FROM mcr.microsoft.com/mssql/server:2019-latest
FROM mcr.microsoft.com/mssql/server:2019-CU27-ubuntu-20.04

SHELL ["/bin/bash", "-c"]

ENV MSSQL_SA_PASSWORD Password123
ENV ACCEPT_EULA Y
ENV MSSQL_PID Enterprise

# # Set working directory
USER root
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


# Copy scripts
COPY ./scripts/* /usr/src/app/
RUN chmod +x ./entrypoints.sh ./run-initialization.sh

ENV PATH="/opt/mssql-tools18/bin:/opt/mssql-tools/bin:${PATH}"