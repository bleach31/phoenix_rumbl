#!/bin/sh
mix local.rebar --force
mix deps.get
cd assets && npm install
cd ..
mix ecto.setup
mix run initdb.exs
