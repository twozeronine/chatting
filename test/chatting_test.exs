defmodule ChattingTest do
  use ExUnit.Case
  doctest Chatting

  test "greets the world" do
    assert Chatting.hello() == :world
  end
end
