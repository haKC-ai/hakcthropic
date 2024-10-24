# Use the Kali Linux rolling release as the base image
FROM kalilinux/kali-rolling

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_PRIORITY=high

# Install packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    build-essential \
    # Add Python Pillow package
    python3-pil \
    # Full Kali Desktop
    kali-desktop-xfce \
    tightvncserver \
    # UI Requirements
    xvfb \
    xterm \
    xdotool \
    scrot \
    imagemagick \
    sudo \
    mutter \
    x11vnc \
    # Python/dev requirements
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    git \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    # Network tools
    net-tools \
    # Userland apps
    tint2 \
    firefox-esr \
    x11-apps && \
    apt-get clean

# Install noVNC
RUN git clone --branch v1.5.0 https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone --branch v0.12.0 https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# Set up user
ENV USERNAME=hakcer
ENV HOME=/home/$USERNAME
RUN useradd -m -s /bin/bash -d $HOME $USERNAME && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user
USER $USERNAME
WORKDIR $HOME

# Create and activate virtual environment
RUN python3 -m venv $HOME/.venv
ENV PATH="$HOME/.venv/bin:$PATH"
ENV VIRTUAL_ENV="$HOME/.venv"

# Install Python packages in virtual environment
RUN . $HOME/.venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install streamlit pillow && \
    pip config set global.disable-pip-version-check true 
    #pip install streamlit==1.24.1 pillow 
    
# Copy requirements and install
COPY --chown=$USERNAME:$USERNAME kali/requirements.txt $HOME/kali/requirements.txt
RUN . $HOME/.venv/bin/activate && \
    pip install -r $HOME/kali/requirements.txt

# Set up desktop environment & application files
COPY --chown=$USERNAME:$USERNAME image/ $HOME
COPY --chown=$USERNAME:$USERNAME kali/ $HOME/kali/

# Set display arguments
ARG DISPLAY_NUM=1
ARG HEIGHT=768
ARG WIDTH=1024
ENV DISPLAY_NUM=$DISPLAY_NUM
ENV HEIGHT=$HEIGHT
ENV WIDTH=$WIDTH
ENV DISPLAY=:$DISPLAY_NUM

# Set up additional environment variables
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=UTF-8

# Entrypoint
ENTRYPOINT [ "./entrypoint.sh" ]
