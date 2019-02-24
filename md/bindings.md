{%
(def title "Bindings (def and var)")
(def description "Janet documentation for def and var. Def and var
 are the two most primitive special forms that create bindings, or assign
 names to values.")
(def prev-page {
 :link "/numbers.html"
 :text "Numbers"})
(def next-page {
 :link "/flow.html"
 :text "Flow"})
%}

Values can be bound to symbols for later use using the keyword `def`. Using undefined
symbols will raise an error.

```janet
(def a 100)
(def b (+ 1 a))
(def c (+ b b))
(def d (- c 100))
```

Bindings created with def have lexical scoping. Also, bindings created with def are immutable; they
cannot be changed after definition. For mutable bindings, like variables in other programming
languages, use the `var` keyword. The assignment special form `set` can then be used to update
a var.

```janet
(var myvar 1)
(print myvar)
(set myvar 10)
(print myvar)
```

In the global scope, you can use the `:private` option on a def or var to prevent it from
being exported to code that imports your current module. You can also add documentation to
a function by passing a string the def or var command.

```janet
(def mydef :private "This will have private scope. My doc here." 123)
(var myvar "docstring here" 321)
```

### Scopes

Defs and vars (collectively known as bindings) live inside what is called a scope. A scope is
simply where the bindings are valid. If a binding is referenced outside of its scope, the compiler
will throw an error. Scopes are useful for organizing your bindings and my extension your programs.
There are two main ways to create a scope in Janet.

The first is to use the `do` special form. `do` executes a series of statements in a scope
and evaluates to the last statement. Bindings create inside the form do not escape outside
of its scope.

```janet
(def a :outera)

(do
 (def a 1)
 (def b 2)
 (def c 3)
 (+ a b c)) # -> 6

a # -> :outera
b # -> compile error: "unknown symbol \"b\""
c # -> compile error: "unknown symbol \"c\""
```

Any attempt to reference the bindings from the do form after it has finished
executing will fail. Also notice who defining `a` inside the do form did not
overwrite the original definition of `a` for the global scope.

The second way to create a scope is to create a closure.
The `fn` special form also introduces a scope just like
the `do` special form.

There is another built in macro, `let`, that does multiple defs at once, and then introduces a scope.
`let` is a wrapper around a combination of defs and dos, and is the most "functional" way of
creating bindings.

```janet
(let [a 1
      b 2
      c 3]
      (+ a b c)) # -> 6
```

The above is equivalent to the example using `do` and `def`.
This is the preferable form in most cases,
but using do with multiple defs is fine as well.

