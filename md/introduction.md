{% (def title "Introduction") %}
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

Which will print out every global binding in the janet REPL.
