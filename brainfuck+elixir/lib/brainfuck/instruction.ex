defmodule Brainfuck.Instruction do
  @type t ::
          :move_right
          | :move_left
          | :increment
          | :decrement
          | :output
          | :input
          | {:open, non_neg_integer()}
          | {:close, non_neg_integer()}

  @spec parse(String.t()) :: list(t())
  def parse(input) do
    ops =
      input
      |> String.to_charlist()
      |> Enum.filter(&(&1 in [?>, ?<, ?+, ?-, ?., ?,, ?[, ?]]))
      |> List.to_tuple()

    for i <- 0..(tuple_size(ops) - 1) do
      case elem(ops, i) do
        ?> ->
          :move_right

        ?< ->
          :move_left

        ?+ ->
          :increment

        ?- ->
          :decrement

        ?. ->
          :output

        ?, ->
          :input

        ?[ ->
          closing =
            (i + 1)..(tuple_size(ops) - 1)
            |> Enum.reduce_while(1, fn j, count ->
              new_count =
                case elem(ops, j) do
                  ?[ -> count + 1
                  ?] -> count - 1
                  _ -> count
                end

              if new_count == 0 do
                {:halt, {:ok, j - i}}
              else
                {:cont, new_count}
              end
            end)

          case closing do
            {:ok, j} -> {:open, j}
            _ -> raise "Unmatched parens"
          end

        ?] ->
          opening =
            (i - 1)..0//-1
            |> Enum.reduce_while(1, fn j, count ->
              new_count =
                case elem(ops, j) do
                  ?[ -> count - 1
                  ?] -> count + 1
                  _ -> count
                end

              if new_count == 0 do
                {:halt, {:ok, i - j}}
              else
                {:cont, new_count}
              end
            end)

          case opening do
            {:ok, j} -> {:close, j}
            _ -> raise "Unmatched parens"
          end
      end
    end
  end
end
