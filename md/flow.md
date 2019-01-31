{%
(def title "Flow Control")
(def description "Janet has only a handful of special forms that are
 used to implement flow control in a Janet program. The if, while, do,
 and fn specials are all that Janet uses to implement branching and loops.")    
%}
Janet has only two built in primitives to change flow while inside a function. The first is the
`if` special form, which behaves as expected in most functional languages. It takes two or three parameters:
a condition, an expression to evaluate to if the condition is true (not nil or false),
and an optional condition to evaluate to when the condition is nil or false. If the optional parameter
is omitted, the if form evaluates to nil.

```janet
(if (> 4 3)
  "4 is greater than 3"
  "4 is not greater then three") # Evaluates to the first statement

(if true
  (print "Hey")) # Will print

(if false
  (print "Oy!")) # Will not print
```

The second primitive control flow construct is the while loop. The while behaves much the same
as in many other programming languages, including C, Java, and Python. The while loop takes
two or more parameters: the first is a condition (like in the `if` statement), that is checked before
every iteration of the loop. If it is nil or false, the while loop ends and evaluates to nil. Otherwise,
the rest of the parameters will be evaluated sequentially and then the program will return to the beginning
of the loop.

```janet
# Loop from 100 down to 1 and print each time
(var i 100)
(while (pos? i)
  (print "the number is " i)
  (-- i))

# Print ... until a random number in range [0, 1) is >= 0.9
# (math/random evaluates to a value between 0 and 1)
(while (> 0.9 (math/random))
  (print "..."))
```

Besides these special forms, Janet has many macros for both conditional testing and looping
that are much better for the majority of cases. For conditional testing, the `cond`, `switch`, and
`when` macros can be used to great effect. `cond` can be used for making an if-else chain, where using
just raw if forms would result in many parentheses. `case` For looping, the `loop`, `seq`, and `generate`
implement janet's form of list comprehension, as in Python or Clojure.

