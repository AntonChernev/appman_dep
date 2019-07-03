defmodule AppmanDep.Connector do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_args) do
    manager_name = Node.self() |> to_string() |> String.split("_") |> List.first()
    manager_node = String.to_atom(manager_name <> "@127.0.0.1")
    Node.connect(manager_node)
    Process.sleep(1000)
    GenServer.cast({:global, Appman.Manager}, {:node_running, Node.self(), self()})
    Process.send_after(self(), :server_timeout, 3000)
    {:ok, false}
  end

  def handle_cast(:stop, state) do
    System.stop()
    {:noreply, state}
  end

  def handle_cast({:server_pid, pid}, _state) do
    Process.monitor(pid)
    {:noreply, true}
  end

  def handle_info({:DOWN, ref, :process, _, _}, state) when Kernel.is_reference(ref) do
    System.stop()
    {:noreply, state}
  end

  def handle_info(:server_timeout, false) do
    System.stop()
    {:noreply, false}
  end

  def handle_info(:server_timeot, true), do: {:noreply, true}
end
