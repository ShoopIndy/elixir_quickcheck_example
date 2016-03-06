# ElixirQuickcheckExample (in Docker)

This repository shows how to use QuviQ’s QuickCheck Mini in Elixir.

Forked from https://github.com/remiq/elixir_quickcheck_example

Just made a little easier to setup by using docker.

## Prerequisities

Docker - https://docs.docker.com/engine/installation/

## Setup

1. `cd [this project]`
2. `docker build -t elixir_quickcheck_example .`

If tests or libraries are added/modified, then re-run the `docker build..` command.

## Running

1. `docker run elixir_quickcheck_example`

This automatically runs `mix tests` for this project.
