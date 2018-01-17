defmodule CounterTcpServer.CounterSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Supervisor.init([CounterTcpServer.Counter], strategy: :simple_one_for_one)
  end

  def start_counter do
    Supervisor.start_child(__MODULE__, [])
  end
end
