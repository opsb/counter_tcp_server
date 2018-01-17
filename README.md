# CounterTcpServer

## Usage

#### Server

To run the server use

```
$ mix run --no-halt
```

#### Client

To connect to the server you should use a TCP client such as telnet e.g.

```
$ telnet 127.0.0.1 9876
```

Once connected the following commands are available:

* INCREMENT - increments the counter's value
* DECREMENT - decrements the counter's value
* READ - displays the value of the counter

Example run using telnet

```
$ telnet 127.0.0.1 9876
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
INCREMENT
INCREMENT
DECREMENT
READ
1
DECREMENT
DECREMENT
READ
-1
```

Each connection has it's own independent counter, to test this simply open two telnet connections and run the commands against each.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `counter_tcp_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:counter_tcp_server, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/counter_tcp_server](https://hexdocs.pm/counter_tcp_server).

