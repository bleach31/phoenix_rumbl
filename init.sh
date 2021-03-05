#!/bin/sh

mix deps.get
mix --force ecto.setup
cd assets && npm install
cd ..
mix ecto.setup
mix run initdb.exs
