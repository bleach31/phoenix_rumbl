FROM gitpod/workspace-postgres
# phoenix book is postgres 8, but we use 10 for easy instalation python 3.5
# Because gigalixir requreieds python 3.5 ( or greater)
ARG DEBIAN_FRONTEND=noninteractive

# Set debconf to noninteractive mode.
RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
# Install custom tools, runtime, etc. using apt-get
#
# More information: https://www.gitpod.io/docs/config-docker/
# USER root

# install basic software
RUN sudo apt update
RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y git nano wget curl

# install elixir 1.8.0

# RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
# RUN sudo apt update
# RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y esl-erlang
# RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y elixir
# RUN sudo apt update && sudo apt install -y build-essential git wget libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl wx-common libwxgtk3.0-dev autoconf procps
# RUN sudo apt update && sudo apt install -y build-essential git wget libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl wx-common libgtk3.0-gtk3-dev autoconf procps
RUN sudo apt update && sudo apt install -y build-essential git wget libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl wx-common libwxgtk3.0-gtk3-dev autoconf procps

USER root

RUN useradd -ms $(which bash) asdf
RUN gpasswd -a asdf sudo

ENV PATH /home/asdf/.asdf/bin:/home/asdf/.asdf/shims:$PATH

USER asdf
RUN echo $HOME
WORKDIR /home/asdf
RUN usermod -d /home/asdf asdf
ENV HOME=/home/asdf
RUN echo $HOME
RUN echo ~
# asdf, erlang

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.1"
RUN /bin/bash -c "asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
                  asdf install erlang 19.3 && \
                  asdf global erlang 19.3 && \
                  rm -rf  /tmp/*"





RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
RUN sed -i '1i#!/bin/bash' $HOME/.asdf/asdf.sh
RUN cat $HOME/.asdf/asdf.sh
RUN . bash -c '$HOME/.asdf/asdf.sh'
RUN . $HOME/.asdf/completions/asdf.bash
RUN exec bash


RUN asdf install erlang 22.3.4.20
RUN asdf global erlang 22.3.4.20
RUN asdf install elixir 1.8.0-otp-22
RUN asdf global elixir 1.8.0-otp-22

USER gitpod

# install phoenix 1.4.7
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.4.7 --force

# install node 5.3.0 -> 10.23.0
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -;
RUN sudo apt update
RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y nodejs
RUN sudo npm install n -g
RUN sudo n 10.23.0
RUN sudo apt purge -y nodejs

# install gigalixir
RUN sudo apt install -y python3 python3-pip git-core curl
RUN pip3 install gigalixir --user
ENV PATH ~/.local/bin:$PATH
#RUN echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile
#RUN source ~/.bash_profile

# install postgresql 9.5.1
#RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
#RUN apt update
#RUN apt install -y postgresql-9.5
#ENV POSTGRES_HOST_AUTH_METHOD=trust

# install inotify-tools
RUN sudo apt install -y inotify-tools

# prepare To start your Phoenix server
# RUN mix deps.get
# RUN cd assets && npm install

# Set debconf back to normal.
USER gitpod
RUN echo 'debconf debconf/frontend select Dialog' | sudo debconf-set-selections

# init elixir
CMD  ["/workspace/phoenix_rumbl/init.sh"]
