defmodule CounterTcpServer do
  alias __MODULE__.{
    TcpServer
  }
  use Application

  def start(:normal, []) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(CounterTcpServer.Supervisor, [[]])
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
