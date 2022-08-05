## :Author: [xlxs4](https://github.com/xlxs4)
## :Version: 0.1.0
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/brBanner.png
##
## ## Description 
## 
## This is a toy interpreter for the [brainfuck](https://www.wikiwand.com/en/Brainfuck)
## programming language written fully in Nim.
## It doubles as a [transpiler](https://www.wikiwand.com/en/Source-to-source_compiler) of brainfuck into efficient Nim code.
## 
## ----
##
## Example:
##
## .. code:: nim
##   import brainfuck, streams
##
##   interpret("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.")
##   # Prints "Hello"
##
##   proc mandelbrot = compileFile("examples/mandelbrot.b")
##   mandelbrot() # Draws a mandelbrot set in ASCII
## 
## ## Introduction
##
## Brainfuck is a very small esoteric programming language.
## It's one of the most famous esoteric languages and has inspired many esoteric programming language creators.
## 
## Brainfuck only consists of eight simple commands.
## It operates on a tape (array) of memory cells, each initially set to zero:
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/memory-tape.png
## 
## There's also a pointer, initially pointing to the first cell:
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/memory-tape-pointer.png
## 
## In other words, there's a data pointer and an instruction pointer (program counter).
## The commands are the following:
## 
## - `>`: Move the pointer to the right
## - `<`: Move the pointer to the left
## - `+`: Increment the memory cell at the pointer
## - `-`: Decrement the memory cell at the pointer
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/instructions-a.png
## 
## - `.`: Output the character signified by the cell at the pointer
## - `,`: Input a character and store it in the cell at the pointer
## - `[`: Jump *past* the *matching* `]` if the cell at the pointer is zero
## - `]`: Jump *back* to the *matching* `[` if the cell at the pointer is *non*zero
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/instructions-b.png
## 
## Or, if you want to be more technical:
## 
## - `>`: Increment the data pointer (to point to the next cell to the right)
## - `<`: Decrement the data pointer (to point to the next cell to the left)
## - `+`: Increment the byte at the data pointer
## - `-`: Decrement the byte at the data pointer
## - `.`: Output the byte at the data pointer
## - `,`: Accept one byte of input, storing its value in the byte at the data pointer
## - `[`: If the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it *forward* to the command after the *matching* `]` command
## - `]`: If the byte at the data pointer is *non*zero, then instead of moving the instruction pointer forward to the next command, jump it *back* to the command after the *matching* `[` command
## 
## .. image:: https://raw.githubusercontent.com/xlxs4/nim-brainfuck-interpreter/master/assets/mandelbrot-brainfuck.gif
## 
## ## Usage
## 
## Usage:
## 
## .. code::
##   brainfuck mandelbrot
##   brainfuck interpret [<file.b>]
##   brainfuck (-h | --help)
##   brainfuck (-v | --version)
## 
## Options:
## 
## .. code::
##   -h --help     Show this screen.
##   -v --version  Show version.
## 
## ## Building
##
## 1. install [nim](https://nim-lang.org/)
## 2. `git clone https://github.com/xlxs4/nim-brainfuck-interpreter.git`
## 3. `cd nim-brainfuck-interpreter/`
## 4. `nimble build`
##
## After that you will get a ready-made binary file in the root directory of the project.
##


import streams

when not defined(nimnode):
  type NimNode = PNimrodNode # Backwards compatibility

proc readCharEOF*(input: Stream): char =
  ## Read a character from `input` stream and return a Unix EOF (-1).
  ## This is necessary because brainfuck assumes Unix EOF while `streams` use \0 for EOF.
  result = input.readChar
  if result == '\0': # Streams return 0 for EOF
    result = '\255'  # BF assumes EOF to be -1

{.push overflowchecks: off.}
proc xinc*(c: var char) = inc c
  ## Increment a character with wrapping instead of overflow checks.
proc xdec*(c: var char) = dec c
  ## Decrement a character with wrapping instead of underflow checks.
{.pop.}

proc interpret*(code: string; input, output: Stream) =
  ## Interpret the brainfuck `code` string, reading from the `input`
  ## and writing to the `output` stream.
  ##
  ## Example:
  ##
  ## .. code:: nim
  ##   var inpStream = newStringStream("Hello World!\n")
  ##   var outStream = newFileStream(stdout)
  ##   interpret(readFile("examples/rot13.b"), inpStream, outStream)
  var
    tape = newSeq[char]()
    codePos = 0
    tapePos = 0

  proc run(skip = false): bool =
    while tapePos >= 0 and codePos < code.len:
      if tapePos >= tape.len:
        tape.add '\0'

      if code[codePos] == '[':
        inc codePos
        let oldPos = codePos
        while run(tape[tapePos] == '\0'):
          codePos = oldPos

      elif code[codePos] == ']':
        return tape[tapePos] != '\0'

      elif not skip:
        case code[codePos]
        of '+': xinc tape[tapePos]
        of '-': xdec tape[tapePos]
        of '>': inc tapePos
        of '<': dec tapePos
        of '.': output.write tape[tapePos]
        of ',': tape[tapePos] = input.readCharEOF
        else: discard

      inc codePos

  discard run()

proc interpret*(code, input: string): string =
  ## Interpret the brainfuck `code` string, reading from the `input`
  ## and returning the result directly.
  ##
  ## Example:
  ##
  ## .. code:: nim
  ##   echo interpret(readFile("examples/rot13.b"), "Hello World!\n")
  var outStream = newStringStream()
  interpret(code, input.newStringStream, outStream)
  result = outStream.data

proc interpret*(code: string) =
  ## Interpret the brainfuck `code`,
  ## reading from stdin and writing to stdout.
  ##
  ## Example:
  ##
  ## .. code:: nim
  ##   interpret(readFile("examples/rot13.b"))
  interpret(code, stdin.newFileStream, stdout.newFileStream)

import macros

proc compile(code, input, output: string): NimNode {.compiletime.} =
  var stmts = @[newStmtList()]

  template addStmt(text) =
    stmts[stmts.high].add parseStmt(text)

  addStmt """
  when not compiles(newStringStream()):
    static:
      quit("Error: Import the streams module to compile brainfuck code", 1)
  """

  addStmt "var inpStream = " & input
  addStmt "var outStream = " & output

  addStmt "var tape: array[1_000_000, char]"
  addStmt "var tapePos = 0"

  for c in code:
    case c
    of '+': addStmt "xinc tape[tapePos]"
    of '-': addStmt "xdec tape[tapePos]"
    of '>': addStmt "inc tapePos"
    of '<': addStmt "dec tapePos"
    of '.': addStmt "outStream.write tape[tapePos]"
    of ',': addStmt "tape[tapePos] = inpStream.readCharEOF"
    of '[': stmts.add newStmtList()
    of ']':
      var loop = newNimNode(nnkWhileStmt)
      loop.add parseExpr("tape[tapePos] != '\\0'")
      loop.add stmts.pop
      stmts[stmts.high].add loop
    else: discard

  result = stmts[0]

macro compileString*(code: string; input, output: untyped) =
  ## Compile the brainfuck `code` read from `filename` at compile time into Nim
  ## code that reads from the `input` variable and writes to the `output`
  ## variable, both of which have to be strings.
  result = compile($code,
    "newStringStream(" & $input & ")", "newStringStream()")
  result.add parseStmt($output & " = outStream.data")

macro compileString*(code: string) =
  ## Compile the brainfuck `code` string into Nim code
  ## that reads from stdin and writes to stdout.
  compile($code, "stdin.newFileStream", "stdout.newFileStream")

macro compileFile*(filename: string; input, output: untyped) =
  ## Compile the brainfuck code read from `filename` at compile time into Nim
  ## code that reads from the `input` variable and writes to the `output`
  ## variable, both of which have to be strings.
  ##
  ## Example:
  ##
  ## .. code-block:: nim
  ##   proc rot13(input: string): string =
  ##     compileFile("examples/rot13.b", input, result)
  ##   echo rot13("Hello World!\n")
  result = compile(staticRead(filename.strVal),
    "newStringStream(" & $input & ")", "newStringStream()")
  result.add parseStmt($output & " = outStream.data")

macro compileFile*(filename: string) =
  ## Compile the brainfuck code read from `filename` at compile time
  ## into Nim code that reads from stdin and writes to stdout.
  ##
  ## Example:
  ##
  ## .. code-block:: nim
  ##   proc mandelbrot = compileFile("examples/mandelbrot.b")
  ##   mandelbrot()
  compile(staticRead(filename.strVal),
          "stdin.newFileStream", "stdout.newFileStream")

when isMainModule:
  import docopt, tables

  proc mandelbrot = compileFile "../examples/mandelbrot.b"

  let doc = """
  brainfuck

  Usage:
    brainfuck mandelbrot
    brainfuck interpret [<file.b>]
    brainfuck (-h | --help)
    brainfuck (-v | --version)

  Options:
    -h --help     Show this screen.
    -v --version  Show version.
  """

  let args = docopt(doc, version = "brainfuck 0.1")

  if args["mandelbrot"]:
    mandelbrot()

  elif args["interpret"]:
    let code = if args["<file.b>"]: readFile($args["<file.b>"])
              else: readAll stdin
    
    interpret(code)
