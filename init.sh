#!/bin/sh

mix deps.get
mix --force ecto.setup
cd assets && npm install
cd ..
mix ecto.migrate
mix run initdb.exs
