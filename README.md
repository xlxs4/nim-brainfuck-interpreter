<div align="center">

[![xlxs4](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter.svg?style=shield)](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter)

</div>

### Description

This is a toy interpreter for the [brainfuck](https://www.wikiwand.com/en/Brainfuck) programming language written fully in Nim.
It doubles as a compiler of brainfuck into efficient Nim code.

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

### Usage

Usage:
```
  brainfuck mandelbrot
  brainfuck interpret [<file.b>]
  brainfuck (-h | --help)
  brainfuck (-v | --version)
```

Options:
```
  -h --help     Show this screen.
  -v --version  Show version.
```

### Building

1. install [nim](https://nim-lang.org/)
2. `git clone https://github.com/xlxs4/nim-brainfuck-interpreter.git`
3. `cd nim-brainfuck-interpreter/`
4. `nimble build`

After that you will get a ready-made binary file in the root directory of the project.

### File architecture
```fish
nim-brainfuck-interpreter
├── brainfuck
│   ├── brainfuck
│   ├── brainfuck.nimble
│   ├── examples
│   │   ├── helloworld.b
│   │   ├── mandelbrot.b
│   │   └── rot13.b
│   ├── src
│   │   ├── brainfuck
│   │   ├── brainfuck.nim
│   │   ├── brainfuck.nim.cfg
│   │   └── htmldocs
│   │       └── brainfuck.html
│   └── tests
│       ├── nim.cfg
│       ├── tcompile.nim
│       └── tinterpret.nim
├── LICENSE
└── README.md

5 directories, 14 files
```
