FROM bleach31/e22e18p14:latest

USER root

# Install Xvfb
RUN apt-get update \
    && apt-get install -yq xvfb x11vnc xterm \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Install novnc
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify
# COPY novnc-index.html /opt/novnc/index.html

# Add VNC startup script
# COPY start-vnc-session.sh /usr/bin/
# RUN chmod +x /usr/bin/start-vnc-session.sh

# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the X
# server is running on screen 0, and if not starts Xvfb, x11vnc and novnc.
# RUN echo "[ ! -e /tmp/.X0-lock ] && (/usr/bin/start-vnc-session.sh 0 &> /tmp/display-0.log)" >> ~/.bashrc
RUN echo "export DISPLAY=:0" >> ~/.bashrc

### checks ###
# no root-owned files in the home directory
RUN notOwnedFile=$(find . -not "(" -user gitpod -and -group gitpod ")" -print -quit) \
    && { [ -z "$notOwnedFile" ] \
        || { echo "Error: not all files/dirs in $HOME are owned by 'gitpod' user & group"; exit 1; } }


RUN sudo apt-get update && \
    sudo apt-get install -y libx11-dev libxkbfile-dev libsecret-1-dev libgconf-2-4 libnss3 && \
    sudo rm -rf /var/lib/apt/lists/*


# install x windows system

RUN apt-get update \
    && apt install -y xfce4 xfce4-goodies

RUN echo "Xvfb :0 -screen 0 1920x1080x32 &" >> ~/.bashrc
RUN echo "startxfce4 &" >> ~/.bashrc
RUN echo "x11vnc -display :0 &" >> ~/.bashrc
RUN echo "/opt/novnc/utils/novnc_proxy  --vnc localhost:5900 &" >> ~/.bashrc
