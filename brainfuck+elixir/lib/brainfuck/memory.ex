defmodule Brainfuck.Memory do
  defstruct store: %{}, idx: 0

  @type t :: %__MODULE__{store: %{non_neg_integer() => integer()}, idx: non_neg_integer()}
  @size 30_000

  def new do
    %__MODULE__{}
  end

  @spec increment(t()) :: t()
  def increment(memory) do
    store = Map.update(memory.store, memory.idx, 1, &(&1 + 1))
    %{memory | store: store}
  end

  @spec decrement(t()) :: t()
  def decrement(memory) do
    store = Map.update(memory.store, memory.idx, -1, &(&1 - 1))
    %{memory | store: store}
  end

  @spec move_left(t()) :: t()
  def move_left(memory) do
    idx =
      if memory.idx == 0 do
        @size - 1
      else
        memory.idx - 1
      end

    %{memory | idx: idx}
  end

  @spec move_right(t()) :: t()
  def move_right(memory) do
    idx =
      if memory.idx == @size - 1 do
        0
      else
        memory.idx + 1
      end

    %{memory | idx: idx}
  end

  @spec put(t(), integer()) :: t()
  def put(memory, value) do
    store = Map.put(memory.store, memory.idx, value)
    %{memory | store: store}
  end

  @spec get(t()) :: integer()
  def get(memory) do
    Map.get(memory.store, memory.idx, 0)
  end
end
