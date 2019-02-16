{%
(def title "Prototypes")
(def description "A Janet table can have a prototype table, which is
 another table that the table will check when a lookup in the table fails
 (returns nil). Prototypes can be used to implement all sorts of interesting
 patterns, including inheritance and Object Oriented programming.")
(def prev-page {
 :link "/peg.html"
 :text "Peg"})
(def next-page {
 :link "/specials.html"
 :text "Specials"})
 %}

To support basic generic programming, Janet tables support a prototype
table. A prototype table contains default values for a table if certain keys
are not found in the original table. This allows many similar tables to share
contents without duplicating memory.

```janet
# Simple Object Oriented behavior in Janet
(def proto1 @{:type :custom1
              :behave (fn [self x] (print "behaving " x))})
(def proto2 @{:type :custom2
              :behave (fn [self x] (print "behaving 2 " x))})

(def thing1 (table/setproto @{} proto1))
(def thing2 (table/setproto @{} proto2))

(print (thing1 :type)) # prints :custom1
(print (thing2 :type)) # prints :custom2

(:behave thing1 :a) # prints "behaving :a"
(:behave thing2 :b) # prints "behaving 2 :b"
```

Looking up a value in a table with a prototype can be summed up with the following algorithm.

1. `(get my-table my-key)` is called.
2. my-table is checked for the key if my-key. If there is a value for the key, it is returned.
3. If there is a prototype table for my-table, set `my-table` = `my-table's prototype` and got to 2. Otherwise go to 4.
4. Return nil as the key was not found.

Janet will check up to about a 1000 prototypes recursively by default before giving up and returning nil. This
is to prevent an infinite loop. This value can be changed by adjusting the `JANET_RECURSION_GUARD` value
in janet.h.

Note that Janet prototypes are not as expressive as metatables in Lua and many other languages.
This is by design, as adding Lua or Python like capabilities would not be technically difficult.
Users should prefer plain data and functions that operate on them rather than mutable objects
with methods. However, some Object Oriented capabilities are useful in Janet for
systems that require extra flexibility.
