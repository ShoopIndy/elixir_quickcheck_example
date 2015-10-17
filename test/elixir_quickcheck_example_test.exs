defmodule ElixirQuickcheckExampleTest do
  use ExUnit.Case
  use EQC.ExUnit
  doctest ElixirQuickcheckExample

  property "Erlang sequence" do
    forall {m, n} <- {int, int} do
      # equals(:lists.seq(m, n), Enum.to_list(m..n))
      ensure :lists.seq(m, n) == Enum.to_list(m..n)
    end
  end
end
