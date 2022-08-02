<div align="center">

# `nim-brainfuck-interpreter`

<h3>
  Toy brainfuck interpreter written in <code>nim👑</code>
</h3>
<br>

[![xlxs4](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter.svg?style=shield)](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter)

</div>

# Description 📖

It's a small [brainfuck](https://www.wikiwand.com/en/Brainfuck) interpreter written fully in `nim👑`.

This is a toy project made to get my feet wet with nim, as a first experience with the language.

If you have any suggestions regarding the source code, feel free to open an issue.

<br>

# Usage

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

<br>

# Building

1. install [nim](https://nim-lang.org/)
2. `git clone https://github.com/xlxs4/nim-brainfuck-interpreter.git`
3. `cd nim-brainfuck-interpreter/`
4. `nimble build`

After that you will get a ready-made binary file in the root directory of the project.

<br>

# File architecture
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
