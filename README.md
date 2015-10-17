# ElixirQuickcheckExample

This repository shows how to use QuviQ’s QuickCheck Mini in Elixir.

## Installation

1. Download QuickCheck Mini: http://www.quviq.com/downloads/
2. Unpack zip somewhere ie. ~/eqcmini-2.01.0/
3. Run iex in this directory

    $ cd ~/eqcmini-2.01.0/
    $ sudo iex

4. Run following command in iex:

    iex(1)> :eqc_install.install()
    Installation program for "Quviq QuickCheck Mini" version 2.01.0.
    Installing in directory /usr/lib/erlang/lib.
    Installing ["eqc-2.01.0"].
    Quviq QuickCheck Mini is installed successfully.
    Bookmark the documentation at /usr/lib/erlang/lib/eqc-2.01.0/doc/index.html.
    :ok

QuickCheck Mini is now installed on your local Erlang VM. Do it once per
development machine. You don't do it in production.

## Mix project changes

Add `:eqc_ex` dependency.

    defp deps do
      [
        {:eqc_ex, "~> 1.2"}
      ]
    end

Run `mix deps.get` and `mix test`. You will get following error:

    == Compilation error on file lib/eqc/mocking.ex ==
    ** (RuntimeError) error parsing file /usr/lib/erlang/lib/eqc-2.01.0/include/eqc_mocking_api.hrl, got: {:error, :enoent}

Now, you will google and you will get this issue: https://github.com/Quviq/eqc_ex/issues/3
Important part:
> There is no free version with eqc_mocking in it, thus it won't work.

This means that `:eqc_ex` will not work with QuickCheck Mini. Or is it?

Edit `deps/eqc_ex/lib/eqc/mocking.ex` and comment lines 25-27:

    #Record.defrecord :api_spec, Record.extract(:api_spec, from_lib: "eqc/include/eqc_mocking_api.hrl")
    #Record.defrecord :api_module, Record.extract(:api_module, from_lib: "eqc/include/eqc_mocking_api.hrl")
    #Record.defrecord :api_fun, Record.extract(:api_fun, from_lib: "eqc/include/eqc_mocking_api.hrl")

Compile deps using `mix compile`. Everything works now.

## Writing property tests

Check `test/elixir_quickcheck_example.exs`. This test was used on ElixirConf EU 2015:
https://www.youtube.com/watch?v=nbpZRm9gl50

Run `mix test` and... it fails:

    ** (CompileError) test/elixir_quickcheck_example_test.exs:8: function equals/2 undefined

After checking `:eqc_ex` sources, change `equals/2` into `ensure a == b`:

    # equals(:lists.seq(m, n), Enum.to_list(m..n))
    ensure :lists.seq(m, n) == Enum.to_list(m..n)

Run `mix test` and it works:

    $ mix test
    ....Failed! After 5 tests.
    {1,0}
    not ensured: [] == [1, 0]
    Shrinking x(0 times)
    {1,0}
    not ensured: [] == [1, 0]


      1) test Property Erlang sequence (ElixirQuickcheckExampleTest)
         test/elixir_quickcheck_example_test.exs:6
         forall({m, n} <- {int, int}) do
           ensure(:lists.seq(m, n) == Enum.to_list(m .. n))
         end
         Failed for {1, 0}
