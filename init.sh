#!/bin/sh

mix deps.get
mix ecto.setup
cd assets && npm install
mix ecto.migrate
elixir  initdb.exs
