defmodule CounterTcpServer.Counter do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, 0)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info({:tcp, socket, packet}, state) do
    handle_command(String.trim(packet), socket, state)
  end

  def handle_info({:tcp_closed, _socket}, state) do
    IO.puts("Socket has been closed")
    {:noreply, state}
  end

  def handle_info({:tcp_error, _socket, reason}, state) do
    IO.puts("connection closed due to #{reason}")
    {:noreply, state}
  end

  defp handle_command("INCREMENT", _socket, state) do
    {:noreply, state + 1}
  end

  defp handle_command("DECREMENT", _socket, state) do
    {:noreply, state - 1}
  end

  defp handle_command("READ", socket, state) do
    :gen_tcp.send(socket, "#{state}\n")
    {:noreply, state}
  end

  defp handle_command(command, socket, state) do
    :gen_tcp.send(socket, "Command not recognised: #{command} \n")
    {:noreply, state}
  end
end
