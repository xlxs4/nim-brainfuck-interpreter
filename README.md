<div align="center">

<img src="assets/brBanner.png">

[![xlxs4](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter.svg?style=shield)](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter)

</div>

### Description

This is a toy interpreter for the [brainfuck](https://www.wikiwand.com/en/Brainfuck) programming language written fully in Nim.
It doubles as a [transpiler](https://www.wikiwand.com/en/Source-to-source_compiler) of brainfuck into efficient Nim code.

This is a toy project made to get my feet wet with nim, as a first experience with the language.
If you have any suggestions regarding the source code, feel free to open an issue.

---

Example:

```nim
import brainfuck, streams

interpret("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.")
# Prints "Hello"

proc mandelbrot = compileFile("examples/mandelbrot.b")
mandelbrot() # Draws a mandelbrot set in ASCIi
```

### Introduction

Brainfuck is a very small esoteric programming language.
It's one of the most famous esoteric languages and has inspired many esoteric programming language creators.

Brainfuck only consists of eight simple commands, a data pointer and an instruction pointer (program counter).
The commands are the following:

- `>`: Increment the data pointer (to point to the next cell to the right)
- `<`: Decrement the data pointer (to point to the next cell to the left)
- `+`: Increment the byte at the data pointer
- `-`: Decrement the byte at the data pointer
- `.`: Output the byte at the data pointer
- `,`: Accept one byte of input, storing its value in the byte at the data pointer
- `[`: If the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it *forward* to the command after the *matching* `]` command
- `]`: If the byte at the data pointer is *non*zero, then instead of moving the instruction pointer forward to the next command, jump it *back* to the command after the *matching* `[` command

### Usage

Usage:

```fish
  brainfuck mandelbrot
  brainfuck interpret [<file.b>]
  brainfuck (-h | --help)
  brainfuck (-v | --version)
```

Options:

```fish
  -h --help     Show this screen.
  -v --version  Show version.
```

### Building

1. install [nim](https://nim-lang.org/)
2. `git clone https://github.com/xlxs4/nim-brainfuck-interpreter.git`
3. `cd nim-brainfuck-interpreter/`
4. `nimble build`

After that you will get a ready-made binary file in the root directory of the project.
