#########################################################################################
# Micro XRCE-DDS Agent Docker
#########################################################################################

# Build stage
FROM ubuntu:22.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root

# Essentials
RUN apt-get update
RUN apt-get install -y \
            software-properties-common \
            build-essential \
            cmake \
            git

# Java
RUN apt install -y openjdk-8-jdk
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"

# Gradle
RUN apt-get install -y gradle git

RUN apt-get clean

# Prepare Micro XRCE-DDS Agent workspace
#RUN mkdir -p /agent/build
#ADD . /agent/
RUN git clone -b v3.0.1 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git /agent/
RUN mkdir -p /agent/build
# Build Micro XRCE-DDS Agent and install
RUN cd /agent/build && \
    cmake -DCMAKE_INSTALL_PREFIX=../install \
    .. &&\
    make -j $(nproc) && make install

# Prepare Micro XRCE-DDS Agent artifacts
RUN cd /agent && \
    tar -czvf install.tar.gz  -C install .

# Final user image
FROM ubuntu:22.04
WORKDIR /root

# Copy Micro XRCE-DDS Agent build artifacts
COPY --from=build /agent/install.tar.gz  /usr/local/
RUN tar -xzvf /usr/local/install.tar.gz -C /usr/local/ &&\
    rm /usr/local/install.tar.gz

COPY --from=build /agent/agent.refs .

RUN ldconfig

#ENTRYPOINT ["MicroXRCEAgent"]
#CMD ["--help"]
