{%
(def title "Macros")
(def description "A macro is a function that transforms some
 Janet source code into some different Janet source code. Calling
 a Janet macro looks like a function call, but the source code itself
 is passed as an argument to the macro. The macro should then return
 some valid Janet code, which will be spliced back into the source code.
 This is a powerful transformation which lets users extend the language
 for themselves.")
%}
Janet supports macros like most lisps. A macro is like a function, but transforms
the code itself rather than data. They let you extend the syntax of the language itself.

You have seen some macros already. The `let`, `loop`, and `defn` forms are macros. When the compiler
sees a macro, it evaluates the macro and then compiles the result. We say the macro has been
*expanded* after the compiler evaluates it. A simple version of the `defn` macro can
be thought of as transforming code of the form

```janet
(defn1 myfun [x] body)
```

into

```janet
(def myfun (fn myfun [x] body))
```

We could write such a macro like so:

```janet
(defmacro defn1 [name args body]
 (tuple 'def name (tuple 'fn name args body)))
```

There are a couple of issues with this macro, but it will work for simple functions
quite well.

The first issue is that our defn2 macro can't define functions with multiple expressions
in the body. We can make the macro variadic, just like a function. Here is a second version
of this macro.

```janet
(defmacro defn2 [name args & body]
 (tuple 'def name (apply tuple 'fn name args body)))
```

Great! Now we can define functions with multiple elements in the body. We can still improve this
macro even more though. First, we can add a docstring to it. If someone is using the function later,
they can use `(doc defn3)` to get a description of the function. Next, we can rewrite the macro
using janet's builtin quasiquoting facilities.

```janet
(defmacro defn3
 "Defines a new function."
 [name args & body]
 ~(def ,name (fn ,name ,args ,;body)))
```

This is functionally identical to our previous version `defn2`, but written in such
a way that the macro output is more clear. The leading tilde `~` is shorthand for the
`(quasiquote x)` special form, which is like `(quote x)` except we can unquote
expressions inside it. The comma in front of `name` and `args` is an unquote, which
allows us to put a value in the quasiquote. Without the unquote, the symbol \'name\'
would be put in the returned tuple, and every function we defined
would be called \'name\'!.

Similar to name, we must also unquote body. However, a normal unquote doesn't work.
See what happens if we use a normal unquote for body as well.

```janet
(def name 'myfunction)
(def args '[x y z])
(defn body '[(print x) (print y) (print z)])

~(def ,name (fn ,name ,args ,body))
# -> (def myfunction (fn myfunction (x y z) ((print x) (print y) (print z))))
```

There is an extra set of parentheses around the body of our function! We don't
want to put the body *inside* the form `(fn args ...)`, we want to *splice* it
into the form. Luckily, janet has the `(splice x)` special form for this purpose,
and a shorthand for it, the ; character.
When combined with the unquote special, we get the desired output.

```janet
~(def ,name (fn ,name ,args ,;body))
# -> (def myfunction (fn myfunction (x y z) (print x) (print y) (print z)))
```

## Hygiene

Sometime when we write macros, we must generate symbols for local bindings. Ignoring that
it could be written as a function, consider
the following macro

```janet
(defmacro max1
 "Get the max of two values."
 [x y]
 ~(if (> ,x ,y) ,x ,y))
```

This almost works, but will evaluate both x and y twice. This is because both show up
in the macro twice. For example, `(max1 (do (print 1) 1) (do (print 2) 2))` will
print both 1 and 2 twice, which is surprising to a user of this macro.

We can do better:

```janet
(defmacro max2
 "Get the max of two values."
 [x y]
 ~(let [x ,x
        y ,y]
    (if (> x y) x y)))
```

Now we have no double evaluation problem! But we now have an even more subtle problem.
What happens in the following code?

```janet
(def x 10)
(max2 8 (+ x 4))
```

We want the max to be 14, but this will actually evaluate to 12! This can be understood
if we expand the macro. You can expand a macro once in janet using the `(macex1 x)` function.
(To expand macros until there are no macros left to expand, use `(macex x)`. Be careful,
 janet has many macros, so the full expansion may be almost unreadable).

```janet
(macex1 '(max2 8 (+ x 4)))
# -> (let (x 8 y (+ x 4)) (if (> x y) x y))
```

After expansion, y wrongly refers to the x inside the macro (which is bound to 8) rather than the x defined
to be 10. The problem is the reuse of the symbol x inside the macro, which overshadowed the original
binding. This problem is called the [hygiene problem](https://en.wikipedia.org/wiki/Hygienic_macro#The_hygiene_problem) which is well known in many programming languages. Some languages provide
complicated solutions to this problem, but Janet opts for a much simpler, if not primitive solution.

Janet provides a general solution to this problem in terms of the `(gensym)` function, which returns
a symbol which is guaranteed to be unique and not collide with any symbols defined previously. We can define
our macro once more for a fully correct macro.

```janet
(defmacro max3
 "Get the max of two values."
 [x y]
 (def $x (gensym))
 (def $y (gensym))
 ~(let [,$x ,x
        ,$y ,y]
    (if (> ,$x ,$y) ,$x ,$y)))
```

Since it is quite common to create several gensyms for use inside a macro body, Janet
provides a macro `with-syms` to make this definition a bit terser.

```janet
(defmacro max4
 "Get the max of two values."
 [x y]
 (with-syms [$x $y]
   ~(let [,$x ,x
          ,$y ,y]
      (if (> ,$x ,$y) ,$x ,$y))))
```

As you can see, macros are very powerful but also are prone to subtle bugs. You must remember that
at their core, macros are just functions that output code, and the code that they return must
work in many contexts! Many times a function will suffice and be more useful that a macro, as
functions can be more easily passed around and used as first class values.
