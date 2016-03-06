FROM shoopindy/elixir_quickcheck

WORKDIR /home/eqc/eqc_elixir

# add config and libraries
ADD ./config    config
ADD ./lib       lib
ADD ./mix.exs   mix.exs

# get dependencies
RUN mix deps.get

# add tests
ADD ./test      test

# compile
RUN mix compile

# run tests
CMD ["mix","test"]
