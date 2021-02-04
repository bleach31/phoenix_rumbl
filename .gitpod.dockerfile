FROM gitpod/workspace-postgres
# phoenix book is postgres 8, but we use 10 for easy instalation python 3.5
# Because gigalixir requreieds python 3.5 ( or greater)
ARG DEBIAN_FRONTEND=noninteractive

USER gitpod
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
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN sudo apt update
RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y esl-erlang
RUN sudo env="DEBIAN_FRONTEND=noninteractive" apt install -y elixir

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
