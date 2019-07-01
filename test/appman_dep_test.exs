defmodule AppmanDepTest do
  use ExUnit.Case
  doctest AppmanDep

  test "greets the world" do
    assert AppmanDep.hello() == :world
  end
end
