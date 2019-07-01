defmodule AppmanDep.Connector do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    IO.puts("Hello")
    {:ok, nil}
  end
end
