## Use Cases

Janet makes a good system scripting language, or a language to embed in other programs. Think Lua or Guile. Janet also can be used for rapid prototying, dynamic systems, and other domains
where lisp shines. Implemented in mostly standard C99, janet runs on Windows, Linux and macOS.
The few features that are not standard C (dynamic library loading, compiler specific optimizations),
are fairly straight forward. Janet can be easily ported to new platforms.

## Features

* Minimal setup - one binary and you are good to go!
* First class closures
* Garbage collection
* First class green threads (continuations)
* Python style generators (implemented as a plain macro)
* Mutable and immutable arrays (array/tuple)
* Mutable and immutable hashtables (table/struct)
* Mutable and immutable strings (buffer/string)
* Lisp Macros
* Byte code interpreter with an assembly interface, as well as bytecode verification
* Tailcall Optimization
* Direct interop with C via abstract types and C functions
* Dynamically load C libraries
* Functional and imperative standard library
* Lexical scoping
* Imperative programming as well as functional
* REPL
* Parsing Expression Grammars built in to the core library
* 300+ functions and macros in the core library
* Interactive environment with detailed stack traces

## Try It
<div id="replblock">
<div id="replterm">

</div>
<div id="replinbar">
  <span id="replprompt">&gt;</span><div contenteditable="true" id="replin">(print "hello, world!")</div>
</div>
</div>

## Usage

A repl is launched when the binary is invoked with no arguments. Pass the -h flag
to display the usage information. Individual scripts can be run with `janet myscript.janet`

If you are looking to explore, you can print a list of all available macros, functions, and constants
by entering the command `(all-bindings)` into the repl.

```
$ janet
Janet 0.3.0-2bad243  Copyright (C) 2017-2019 Calvin Rose
janet:0:> (+ 1 2 3)
6
janet:10:> (print "Hello, world!")
Hello, world!
nil
janet:34:> (os/exit)
$ janet -h
usage: janet [options] script args...
Options are:
  -h Show this help
  -v Print the version string
  -s Use raw stdin instead of getline like functionality
  -e Execute a string of janet
  -r Enter the repl after running all scripts
  -p Keep on executing if there is a top level error (persistent)
  -q Hide prompt, logo, and repl output (quiet)
  -l Execute code in a file before running the main script
  -- Stop handling options
```

## Discussion

Feel free to ask questions and join discussion on the [Janet Gitter Channel](https://gitter.im/janet-language/community).
Alternatively, check out [the #janet channel on Freenode](https://webchat.freenode.net/)
