defmodule Chatting.Client do
  def connect(server_pid) do
    spawn(__MODULE__, :loop, [server_pid])
  end

  def loop(server_pid, state \\ :connect)
  def loop(server_pid, :msg) do
    receive do
      {:msg, msg} ->
        send(server_pid, {:msg, self(), msg})
        loop(server_pid, :broad_cast)
    end
  end
  def loop(server_pid, :broad_cast) do
    receive do
      {:broad_cast, msg} ->
        IO.inspect(msg)
        loop(server_pid, :msg)
    end
  end
  def loop(server_pid, state)
  do
    send(server_pid, {state, self()})
    loop(server_pid, :msg)
  end
end
