FROM trenpixster/elixir

# https://github.com/remiq/elixir_quickcheck_example

ENV FOLDER /home/eqc/eqc_elixir

# install quickcheck mini
RUN mkdir /home/eqc
RUN cd /home/eqc && wget http://www.quviq.com/wp-content/uploads/2015/09/eqcmini-2.01.0.zip && unzip eqcmini-2.01.0.zip && rm -f eqcmini-2.01.0.zip
RUN cd /home/eqc && erl -run eqc_install install -run init stop -noshell

# config and libraries
ADD ./config $FOLDER/config
ADD ./lib $FOLDER/lib
ADD ./mix.exs $FOLDER/mix.exs

# get dependencies
RUN cd $FOLDER && mix deps.get

# get tests
ADD ./test $FOLDER/test

# compile
RUN cd $FOLDER && mix compile

WORKDIR $FOLDER

# run tests
CMD ["mix","test"]
