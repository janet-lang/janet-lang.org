{%
(def title "Functions")
(def description "Functions are the main means of abstraction in Janet, and
 can be created dynamically and passed around like any other value.
 This means functions are first class in the language.")
%}

Janet is a functional language - that means that one of the basic building blocks of your
program will be defining functions (the other is using data structures). Because janet
is a Lisp, functions are values just like numbers or strings - they can be passed around and
created as needed.

Functions can be defined with the `defn` macro, like so:

```janet
(defn triangle-area
 "Calculates the area of a triangle."
 [base height]
 (print "calculating area of a triangle...")
 (* base height 0.5))
```

A function defined with `defn` consists of a name, a number of optional flags for def, and
finally a function body. The example above is named triangle-area and takes two parameters named base and height. The body of the function will print a message and then evaluate to the area of the triangle.

Once a function like the above one is defined, the programmer can use the `triangle-area`
function just like any other, say `print` or `+`.

```janet
# Prints "calculating area of a triangle..." and then "25"
(print (triangle-area 5 10))
```

Note that when nesting function calls in other function calls like above (a call to triangle-area is
nested inside a call to print), the inner function calls are evaluated first. Also, arguments to
a function call are evaluated in order, from first argument to last argument).

Because functions are first-class values like numbers or strings, they can be passed
as arguments to other functions as well.

```janet
(print triangle-area)
```

This prints the location in memory of the function triangle area.

Functions don't need to have names. The `fn` keyword can be used to introduce function
literals without binding them to a symbol.

```janet
# Evaluates to 40
((fn [x y] (+ x x y)) 10 20)
# Also evaluates to 40
((fn [x y &] (+ x x y)) 10 20)

# Will throw an error about the wrong arity
((fn [x] x) 1 2)
# Will not throw an error about the wrong arity
((fn [x &] x) 1 2)
```

The first expression creates an anonymous function that adds twice
the first argument to the second, and then calls that function with arguments 10 and 20.
This will return (10 + 10 + 20) = 40.

There is a common macro `defn` that can be used for creating functions and immediately binding
them to a name. `defn` works as expected at both the top level and inside another form. There is also
the corresponding

Note that putting an ampersand at the end of the argument list inhibits strict arity checking.
This means that such a function will accept fewer or more arguments than specified.

```janet
(defn myfun [x y]
 (+ x x y))

# You can think of defn as a shorthand for def and fn together
(def myfun-same (fn [x y]
            (+ x x Y)))

(myfun 3 4) # -> 10
```

Janet has many macros provided for you (and you can write your own).
Macros are just functions that take your source code
and transform it into some other source code, usually automating some repetitive pattern for you.
