defmodule AppmanDep.Connector do
  use GenServer

  @doc """
  State contains a single boolean value.
  It indicates whether Appman Manager has responded to initial connection.
  """

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Notifies Manager that the application is successfully started.
  Sends a message to self to handle Manager timeout.
  """
  def init(_args) do
    manager_name = Node.self() |> to_string() |> String.split("_") |> List.first()
    manager_node = String.to_atom(manager_name <> "@127.0.0.1")
    Node.connect(manager_node)
    Process.sleep(1000)
    GenServer.cast({:global, Appman.Manager}, {:node_running, Node.self(), self()})
    Process.send_after(self(), :server_timeout, 3000)
    {:ok, false}
  end

  @doc """
  Manager asks for stop.
  """
  def handle_cast(:stop, state) do
    System.stop()
    {:noreply, state}
  end

  @doc """
  Manager sends its pid so that it can be monitored.
  """
  def handle_cast({:server_pid, pid}, _state) do
    Process.monitor(pid)
    {:noreply, true}
  end

  @doc """
  Message from monitor - Manager is dead, the application must stop.
  """
  def handle_info({:DOWN, ref, :process, _, _}, state) when Kernel.is_reference(ref) do
    System.stop()
    {:noreply, state}
  end

  @doc """
  Manager has not responded to initial connection, the application must stop.
  """
  def handle_info(:server_timeout, false) do
    System.stop()
    {:noreply, false}
  end

  @doc """
  Ignore server timeout if Manager has already responded.
  """
  def handle_info(:server_timeout, true), do: {:noreply, true}
end
