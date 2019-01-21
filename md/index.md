Implemented in mostly standard C99, janet runs on Windows, Linux and macOS.
The few features that are not standard C (dynamic library loading, compiler specific optimizations),
are fairly straight forward. Janet can be easily ported to new platforms.

For syntax highlighting, there is some preliminary vim syntax highlighting in [janet.vim](https://github.com/janet-lang/janet.vim).
Generic lisp syntax highlighting should, however, provide good results. One can also generate a janet.tmLanguage
file for other programs with `make grammar`.

## Use Cases

Janet makes a good system scripting language, or a language to embed in other programs. Think Lua or Guile. Janet also can be used for rapid prototying, dynamic systems, and other domains
where lisp shines.

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

## Documentation

Documentation can be found in the doc directory of
the repository. There is an introduction
section contains a good overview of the language.

API documentation for all bindings can also be generated
with `make docs`, which will create `build/doc.html`, which
can be viewed with any web browser. This
includes all forms in the core library except special forms.

For individual bindings from within the REPL, use the `(doc symbol-name)` macro to get API
documentation for the core library. For example,

```
(doc doc)
```

Shows documentation for the doc macro.

To get a list of all bindings in the default
environment, use the `(all-symbols)` function.

## Installation

Install a stable version of janet from the [releases page](https://github.com/janet-lang/janet/releases).
Janet is prebuilt for a few systems, but if you want to develop janet, run janet on a non-x86 system, or
get the latest, you must build janet from source. Janet is in alpha and may change
in backwards incompatible ways.

## Usage

A repl is launched when the binary is invoked with no arguments. Pass the -h flag
to display the usage information. Individual scripts can be run with `./janet myscript.janet`

If you are looking to explore, you can print a list of all available macros, functions, and constants
by entering the command `(all-symbols)` into the repl.

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

## Compiling and Running

Janet only uses Make and batch files to compile on Posix and windows
respectively. To configure janet, edit the header file src/include/janet/janet.h
before compilation.

### macos and Unix-like

On most platforms, use Make to build janet. The resulting binary will be in `build/janet`.

```
cd somewhere/my/projects/janet
make
make test
```

After building, run `make install` to install the janet binary and libs.
Will install in `/usr/local` by default, see the Makefile to customize.

It's also recommended to set the `JANET_PATH` variable in your profile.
This is where janet will look for imported libraries after the current directory.

### FreeBSD

FreeBSD build instructions are the same as the unix-like build instuctions,
but you need `gmake` and `gcc` to compile.

```
cd somewhere/my/projects/janet
gmake CC=gcc
gmake test CC=gcc
```

### Windows

1. Install [Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=15#) or [Visual Studio Build Tools](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15#)
2. Run a Visual Studio Command Prompt (cl.exe and link.exe need to be on the PATH) and cd to the directory with janet.
3. Run `build_win` to compile janet.
4. Run `build_win test` to make sure everything is working.

### Emscripten

To build janet for the web via [Emscripten](https://kripken.github.io/emscripten-site/), make sure you
have `emcc` installed and on your path. On a linux or macOS system, use `make emscripten` to build
`janet.js` and `janet.wasm` - both are needed to run janet in a browser or in node.
The JavaScript build is what runs the repl on the main website,
but really serves mainly as a proof of concept. Janet will run slower in a browser.
Building with emscripten on windows is currently unsupported.

## Examples

See the examples directory for some example janet code.

## IRC

Feel free to ask questions and join discussion on [the #janet channel on Freenode](https://webchat.freenode.net/)
