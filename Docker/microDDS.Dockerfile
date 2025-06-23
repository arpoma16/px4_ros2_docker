FROM ubuntu:22.04

# Install Micro-XRCE-DDS-Agent v3.0.1
WORKDIR /Microdds/
RUN git clone -b v3.0.1 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
WORKDIR /home/grvc/Micro-XRCE-DDS-Agent
RUN mkdir build
WORKDIR /home/grvc/Micro-XRCE-DDS-Agent/build
RUN cmake .. 
RUN make -j4
RUN make install -j4
RUN ldconfig /usr/local/lib/

CMD ["bash", "-c", " MicroXRCEAgent udp4 -p 8888"]
