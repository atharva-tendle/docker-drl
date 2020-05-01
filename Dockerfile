FROM unlhcc/cuda-ubuntu:9.2
MAINTAINER Atharva Tendle <atharva.tendle@huskers.unl.edu>

#github https://github.com/atharva-tendle/docker-drl


ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \ 
    apt-utils \ 
    git \ 
    curl \ 
    vim \ 
    unzip \ 
    wget \
    build-essential cmake \ 
    libopenblas-dev 

# Python 3.5
# For convenience, alias (but don't sym-link) python & pip to python3 & pip3 as recommended in:
# http://askubuntu.com/questions/351318/changing-symlink-python-to-python3-causes-problems
RUN apt-get install -y --no-install-recommends \
    python3.5 \
    python3.5-dev \
    python3-pip \
    python3-tk \
    && pip3 install --no-cache-dir --upgrade pip setuptools \
    && echo "alias python='python3'" >> /root/.bash_aliases \
    && echo "alias pip='pip3'" >> /root/.bash_aliases

# Pillow and it's dependencies
RUN apt-get install -y --no-install-recommends libjpeg-dev zlib1g-dev && \
    pip3 --no-cache-dir install 'pillow<7'

# Science libraries and other common packages
RUN pip3 --no-cache-dir install \
    numpy scipy sklearn scikit-image pandas matplotlib requests

# Install PyTorch (and friends) for both Python 3.5
RUN pip3 --no-cache-dir install 'torchvision==0.4.0' 'torch==1.2.0' torchsummary numpy scipy scikit-learn scikit-image 'networkx==2.0'

# TensorBoard X
RUN pip3 install tensorboardX

#Tensorflow 2.1.0
RUN pip3 install --no-cache-dir --upgrade tensorflow 

# Expose port for TensorBoard
EXPOSE 6006

# Keras 2.3.1
RUN pip3 install --no-cache-dir --upgrade Cython h5py pydot_ng keras

# gym
RUN pip3 install gym

RUN pip install --upgrade pip

WORKDIR "/root"
CMD ["/bin/bash"]
