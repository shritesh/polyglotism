defmodule Brainfuck.MemoryTest do
  use ExUnit.Case
  alias Brainfuck.Memory

  test "sample run" do
    Memory.new()
    # index: 0
    |> tap(&assert Memory.get(&1) == 0)
    |> Memory.move_right()
    # index: 1
    |> Memory.put(42)
    |> tap(&assert Memory.get(&1) == 42)
    |> Memory.move_left()
    # index: 0
    |> tap(&assert Memory.get(&1) == 0)
    |> Memory.put(24)
    |> Memory.increment()
    |> tap(&assert Memory.get(&1) == 25)
    |> Memory.move_left()
    # index: 29_999
    |> Memory.put(14)
    |> Memory.decrement()
    |> tap(&assert Memory.get(&1) == 13)
    |> Memory.move_right()
    # index: 0
    |> tap(&assert Memory.get(&1) == 25)
    |> Memory.move_right()
    # index: 1
    |> tap(&assert Memory.get(&1) == 42)
    |> Memory.move_right()
    # index: 2
    |> tap(&assert Memory.get(&1) == 0)
  end
end
