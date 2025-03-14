FROM lscr.io/linuxserver/webtop:amd64-ubuntu-kde-version-b7c41cf2

# Configure environment
ENV DOCKER_IMAGE_NAME='ofpv-env'
ENV VERSION='2025-03-14' 

# title
ENV TITLE=OpenFOAM-Paraview

# ports and volumes
EXPOSE 3000

VOLUME /config

RUN apt-get update && \
    apt-get install -y vim git\ 
                       python-is-python3 \
                       python3-pip

# Install required packages and OpenFOAM
RUN apt-get update && \
    apt-get install -y bc wget software-properties-common && \
    wget -O - https://dl.openfoam.org/gpg.key | tee /etc/apt/trusted.gpg.d/openfoam.asc && \
    add-apt-repository http://dl.openfoam.org/ubuntu && \
    apt-get update && \
    apt-get install -y --no-install-recommends openfoam9 && \
    echo ". /opt/openfoam9/etc/bashrc" >> /etc/bash.bashrc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install required packages for Paraview
RUN apt update && \
    apt install -y xvfb

# Install ParaView
RUN wget https://www.paraview.org/files/v5.10/ParaView-5.10.1-MPI-Linux-Python3.9-x86_64.tar.gz && \
    tar -xvf ParaView-5.10.1-MPI-Linux-Python3.9-x86_64.tar.gz -C /opt/ && \
    rm ParaView-5.10.1-MPI-Linux-Python3.9-x86_64.tar.gz && \
    ln -s /opt/ParaView-5.10.1-MPI-Linux-Python3.9-x86_64/bin/paraview /usr/local/bin/paraview && \
    ln -s /opt/ParaView-5.10.1-MPI-Linux-Python3.9-x86_64/bin/pvbatch /usr/local/bin/pvbatch

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

# Set environment variables for OpenFOAM
ENV FOAM_INST_DIR=/usr/lib/openfoam \
    FOAM_VERSION=9 \
    PATH="/usr/lib/openfoam/openfoam9/bin:/usr/lib/openfoam/openfoam9/wmake:$PATH"
