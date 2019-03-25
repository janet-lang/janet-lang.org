{%
(def title "Introduction")
(def description "Getting started with Janet. Janet can be installed from a prebuilt binary,
 built from source, or embedded into an application. The
 easiest way to get started is the online web REPL.")
(def prev-page {
 :link "/"
 :text "Home"})
(def next-page {
 :link "/syntax.html"
 :text "Syntax"})
%}

## Installation

Install a stable version of janet from the [releases page](https://github.com/janet-lang/janet/releases).
Janet is prebuilt for a few systems, but if you want to develop janet, run janet on a non-x86 system, or
get the latest, you must build janet from source. Janet is in alpha and may change
in backwards incompatible ways.

### Windows

On Windows, the easiest way to install is via the [scoop](https://scoop.sh)
package manager. You will first need to add the janet-lang bucket, and then you can install janet
normally.

```
scoop bucket add janet-lang https://github.com/janet-lang/scoop
scoop install janet
```

## Compiling and Running from Source

If you would like the latest version of Janet, are trying to run Janet on
a platform that is not macos or Windows, or would like to help develop
Janet, you can build janet from source.
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

## First Program

Following tradition, a simple Janet program will print "Hello, world!".

```janet
(print "Hello, world!")
```

Put the following code in a file named `hello.janet`, and run `janet hello.janet`.
The words "Hello, world!" should be printed to the console, and then the program
should immediately exit. You now have a working janet program!

Alternatively, run the program `janet` without any arguments to enter a REPL,
or read eval print loop. This is a mode where Janet works like a calculator,
reading some input from the user, evaluating it, and printing out the result, all
in an infinite loop. This is a useful mode for exploring or prototyping in Janet.

This hello world program is about the simplest program one can write, and consists of only
a few pieces of syntax. This first element is the `print` symbol. This is a function
that simply prints its arguments to the console. The second argument is the
string literal "Hello, world!", which is the one and only argument to the
print function. Lastly, the print symbol and the string literal are wrapped
in parentheses, forming a tuple. In Janet, parentheses and brackets are interchangeable,
brackets are used mostly when the resulting tuple is not a function call. The tuple
above indicates that the function `print` is to be called with one argument, `"Hello, world"`.

Like all lisps, all operations in Janet are in prefix notation; the name of the
operator is the first value in the tuple, and the arguments passed to it are
in the rest of the tuple.

## The Core Library

Janet has a built in core library of over 300 functions and macros at the time of writing.
For efficient programming in Janet, it is good to be able to make use of many of these
functions.

If at any time you want to see short documentation on
a binding, Use the `doc` macro to view the documentation for it in the REPL.

```janet
(doc defn) # -> Prints the documentation for "defn"
```

To see a list of all global functions in the REPL, type the command

```janet
(all-bindings)
```

Which will print out every global binding in the janet REPL. You can also
browse the [Core Library API on the website](/doc.html).
