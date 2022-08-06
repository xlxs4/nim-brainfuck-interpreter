import unittest, brainfuck, streams

suite "brainfuck tests":
  test "test for obscure problems":
    proc oproblems: string =
      compileFile("bf/obscure-problems.b", "", result)
    check oproblems() == "H\n"

  test "test tape is at least 30000 cells long":
    proc tape: string =
      compileFile("bf/tape-big-enough.b", "", result)
    check tape() == "#\n"