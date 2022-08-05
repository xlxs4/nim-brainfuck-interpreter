<div align="center">

[![xlxs4](https://img.shields.io/circleci/build/github/xlxs4/nim-brainfuck-interpreter/main?color=pink&logo=circleci)](https://circleci.com/gh/xlxs4/nim-brainfuck-interpreter)
[![xlxs4](https://img.shields.io/github/workflow/status/xlxs4/nim-brainfuck-interpreter/Build%20and%20Test?color=purple&logo=github)](https://github.com/xlxs4/nim-brainfuck-interpreter/actions/workflows/build_and_test.yml)
[![xlxs4](https://img.shields.io/github/workflow/status/xlxs4/nim-brainfuck-interpreter/Deploy%20static%20content%20to%20Pages?color=teal&label=deploy&logo=github)](https://github.com/xlxs4/nim-brainfuck-interpreter/actions/workflows/pages.yml)

</div>

---

Example:

```nim
import brainfuck, streams

interpret("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.")
# Prints "Hello"

proc mandelbrot = compileFile("examples/mandelbrot.b")
mandelbrot() # Draws a mandelbrot set in ASCIi
```

### Description

This is a toy interpreter for the [brainfuck](https://www.wikiwand.com/en/Brainfuck) programming language written fully in Nim.
It doubles as a [transpiler](https://www.wikiwand.com/en/Source-to-source_compiler) of brainfuck into efficient Nim code.

This is a toy project made to get my feet wet with nim, as a first experience with the language.
If you have any suggestions regarding the source code, feel free to open an issue.

### Building

1. install [nim](https://nim-lang.org/)
2. `git clone https://github.com/xlxs4/nim-brainfuck-interpreter.git`
3. `cd nim-brainfuck-interpreter/`
4. `nimble build`

After that you will get a ready-made binary file in the root directory of the project.

### 👉 Visit the documentation page for more: https://xlxs4.github.io/nim-brainfuck-interpreter/
