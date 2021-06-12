defmodule Brainfuck do
  alias Brainfuck.{Instruction, Memory}

  def run(source, input \\ "") do
    instructions =
      source
      |> Instruction.parse()
      |> List.to_tuple()

    Stream.resource(
      fn -> {0, Memory.new(), String.to_charlist(input)} end,
      fn {pc, memory, chars} ->
        if pc == tuple_size(instructions) do
          {:halt, :done}
        else
          case elem(instructions, pc) do
            :move_right ->
              {[], {pc + 1, Memory.move_right(memory), chars}}

            :move_left ->
              {[], {pc + 1, Memory.move_left(memory), chars}}

            :increment ->
              {[], {pc + 1, Memory.increment(memory), chars}}

            :decrement ->
              {[], {pc + 1, Memory.decrement(memory), chars}}

            :output ->
              {[Memory.get(memory)], {pc + 1, memory, chars}}

            :input ->
              {c, rest} =
                case chars do
                  [] -> {0, []}
                  [c] -> {c, []}
                  [c | rest] -> {c, rest}
                end

              {[], {pc + 1, Memory.put(memory, c), rest}}

            {:open, jump} ->
              if Memory.get(memory) == 0 do
                {[], {pc + jump, memory, chars}}
              else
                {[], {pc + 1, memory, chars}}
              end

            {:close, jump} ->
              if Memory.get(memory) != 0 do
                {[], {pc - jump, memory, chars}}
              else
                {[], {pc + 1, memory, chars}}
              end
          end
        end
      end,
      fn _ -> nil end
    )
    |> Enum.to_list()
    |> to_string()
  end
end
