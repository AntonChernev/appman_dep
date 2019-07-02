defmodule AppmanDep.Connector do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_args) do
    manager_name = Node.self() |> to_string() |> String.split("-") |> List.first()
    manager_node = String.to_atom(manager_name <> "@localhost")
    Node.connect(manager_node)
    GenServer.cast({:global, manager_name}, {:node_running, Node.self(), self()})
    {:ok, nil}
  end

  def handle_cast(:stop, state) do
    System.stop()
    {:noreply, state}
  end
end
