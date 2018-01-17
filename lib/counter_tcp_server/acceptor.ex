defmodule CounterTcpServer.Acceptor do
  # alias CounterTcpServer.Counter
  alias CounterTcpServer.CounterSupervisor
  use GenServer

  @port_wait_interval 500

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    ip = Application.get_env(:counter_tcp_server, :ip)
    port = Application.get_env(:counter_tcp_server, :port)
    gen_tcp_options = [:binary, {:packet, 0}, {:active, true}, {:ip, ip}]

    {:ok, acceptor_socket} = :gen_tcp.listen(port, gen_tcp_options)
    # TODO - handle port not available - e.g. use incremental backoff
    accept_connection()
    {:ok, acceptor_socket}
  end

  defp accept_connection() do
    GenServer.cast(self(), :accept)
  end

  def handle_cast(:accept, acceptor_socket) do
    {:ok, client_socket} = :gen_tcp.accept(acceptor_socket)
    {:ok, client_server} = CounterSupervisor.start_counter
    :ok = :gen_tcp.controlling_process(client_socket, client_server)
    accept_connection()
    {:noreply, acceptor_socket}
  end

  def terminate(reason, acceptor_socket) do
    :gen_tcp.close(acceptor_socket)
    # TODO - block until port is released
    :ok
  end
end
