FROM nvidia/cuda:10.1-base-ubuntu18.04
ENV TERM xterm-256color
ARG e1=env_lmq
ARG e2=env_nhtl
RUN apt-get -qq update && apt-get -y --no-install-recommends install python3 python3-distutils curl bash-completion libgtk2.0-dev libgl1-mesa-glx &&\
    curl -sLO https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py &&\
    pip3 install --no-cache-dir -U virtualenv &&\
    rm -rf get-pip.py /var/lib/apt/lists/*

RUN curl -sLO https://raw.githubusercontent.com/hcmus18120134/AIC-docker/master/$e1/requirements.txt &&\
    virtualenv --system-site-packages ~/$e1 &&\
    ~/$e1/bin/pip install --no-cache-dir -r requirements.txt &&\
    ~/$e1/bin/pip install --no-cache-dir torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html &&\
    rm -rf requirements.txt /var/lib/apt/lists/*

RUN curl -sLO https://raw.githubusercontent.com/hcmus18120134/AIC-docker/master/$e2/requirements.txt &&\
    virtualenv --system-site-packages ~/$e2 &&\
    ~/$e2/bin/pip install --no-cache-dir -r requirements.txt &&\
    ~/$e2/bin/pip install --no-cache-dir tqdm &&\
    rm -rf requirements.txt /var/lib/apt/lists/*

RUN echo "alias $e1='source ~/$e1/bin/activate'" >> ~/.bashrc &&\
    echo "alias $e2='source ~/$e2/bin/activate'" >> ~/.bashrc

