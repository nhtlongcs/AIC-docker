FROM nvidia/cuda:10.1-base
RUN apt-get update 
RUN apt-get install -y python3.6
RUN apt install -y python3-pip
RUN apt-get install -y wget 
RUN pip3 install cmake
RUN pip3 install scikit-build
COPY ./ws/* /aic-ws/
WORKDIR /aic-ws/
RUN apt-get update 
RUN pip3 install -r /aic-ws/requirements.txt