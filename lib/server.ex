defmodule Chatting.Server do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop(clients \\ [])

  def loop(clients) do
    receive do
      {:connect, pid} ->
        IO.inspect("connected!")
        loop([pid | clients])

      {:msg, pid, msg} ->
        Enum.map(clients, fn client ->
          send(client, {:broad_cast, " #{inspect(pid)} :  #{msg}"})
        end)

        loop(clients)

      _ ->
        IO.inspect("Invaild Message")
        loop(clients)
    end
  end
end
