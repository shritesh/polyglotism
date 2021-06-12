defmodule Brainfuck.InstructionTest do
  use ExUnit.Case
  alias Brainfuck.Instruction

  test "parse matching parens" do
    assert Instruction.parse("Hello[[][[]][]]Goodbye") == [
             open: 9,
             open: 1,
             close: 1,
             open: 3,
             open: 1,
             close: 1,
             close: 3,
             open: 1,
             close: 1,
             close: 9
           ]
  end

  test "parse mismatched parens" do
    assert_raise(RuntimeError, "Unmatched parens", fn -> Instruction.parse("[[]") end)
    assert_raise(RuntimeError, "Unmatched parens", fn -> Instruction.parse("[]]") end)
  end
end
