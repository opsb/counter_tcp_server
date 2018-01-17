defmodule CounterTcpServerTest do
  use ExUnit.Case
  doctest CounterTcpServer

  test "greets the world" do
    assert CounterTcpServer.hello() == :world
  end
end
