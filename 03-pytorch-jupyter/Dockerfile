FROM nvcr.io/nvidia/l4t-base:r32.2

MAINTAINER benson

RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    libjpeg-dev \
    zlib1g-dev \
    python-dev libfreetype6-dev \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://nvidia.box.com/shared/static/phqe92v26cbhqjohwtvxorrwnmrnfx1o.whl -O torch-1.3.0-cp36-cp36m-linux_aarch64.whl && \
    pip3 install \
    numpy \
    torch-1.3.0-cp36-cp36m-linux_aarch64.whl \
    Pillow \
    torchvision \
    jupyter \
    matplotlib && \
    rm -rf /root/.cache/pip && \
    rm -rf ./torch-1.3.0-cp36-cp36m-linux_aarch64.whl && \
    jupyter notebook --generate-config && \
    echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /
CMD ["bash"]
