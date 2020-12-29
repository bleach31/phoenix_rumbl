FROM gitpod/workspace-postgres
# phoenix book is postgres 8, but we use 10 for easy instalation python 3.5
# Because gigalixir requreieds python 3.5 ( or greater)

# install basic software
RUN apt update
RUN apt install -y git nano wget curl

# install elixir 1.8.0
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && dpkg -i erlang-solutions_2.0_all.deb
RUN apt update
RUN apt install -y esl-erlang
RUN apt install -y elixir=1.8.0-1

# install phoenix 1.4.7
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.4.7 --force

# install node 5.3.0 -> 10.23.0
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -;
RUN apt update
RUN apt install -y nodejs
RUN npm install n -g
RUN n 10.23.0
RUN apt purge -y nodejs

# install gigalixir
RUN apt-get install -y python3 python3-pip git-core curl
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
RUN apt install -y inotify-tools