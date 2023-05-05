
FROM ubuntu:20.04

RUN apt update && \
    apt install -y \
        wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://www.python.org/ftp/python/3.9.12/Python-3.9.12.tgz && \
    tar -xvf Python-3.9.12.tgz && \
    cd Python-3.9.12 && \
    ./configure --enable-optimizations && \
    make && make install && \
    cd .. && rm Python-3.9.12.tgz && rm -r Python-3.9.12 && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3 /usr/local/bin/pip && \
    python -m pip install --upgrade pip && \
    rm -r /root/.cache/pip

RUN pip3 install torch==2.0.0+cpu torchvision==0.15.0+cpu torchaudio==2.0.0+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html && \
    rm -r /root/.cache/pip

# install pyg&graph-learn&torch
RUN pip3 install graph-learn==1.1.0 torch_geometric numpy==1.23.4 && \
    rm -r /root/.cache/pip

RUN pip3 install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.0.0+cpu.html && \
    rm -r /root/.cache/pip

WORKDIR /workspace
