defmodule CounterTcpServer.Supervisor do
  use Supervisor
  alias CounterTcpServer.AcceptorSupervisor
  alias CounterTcpServer.CounterSupervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      CounterSupervisor,
      worker(CounterTcpServer.Acceptor, [])
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
