{%
(def title "Destructuring")
(def description "Like many lisps, Janet supports destructuring to
 extract values from data structures in a convenient and succinct way.")
(def prev-page {
 :link "/macros.html"
 :text "Macros"})
(def next-page {
 :link "/fibers.html"
 :text "Fibers"})
%}

Janet uses the `get` function to retrieve values from inside data
structures.  In many cases, however, you do not need the `get`
function at all. Janet supports destructuring, which means both the
`def` and `var` special forms can extract values from inside
structures themselves.

```janet
# Before, we might do
(def my-array @[:mary :had :a :little :lamb])
(def lamb (get my-array 4))
(print lamb) # Prints :lamb

# Now, with destructuring,
(def [_ _ _ _ lamb] my-array)
(print lamb) # Again, prints :lamb

# Destructuring works with tables as well
(def person @{:name "Bob Dylan" :age 77})
(def
  {:name person-name
   :age person-age} person)
```

To update a mutable data structure, use the `put` function. It takes 3 arguments, the data structure,
the key, and the value, and returns the data structure. The allowed types keys and values
depend on what data structure is passed in.

```janet
(put @[] 100 :a)
(put @{} :key "value")
(put @"" 100 92)
```

Note that for Arrays and Buffers, putting an index that is outside the length of the data structure
will extend the data structure and fill it with nils in the case of the Array,
or 0s in the case of the Buffer.

The last generic function for all data structures is the `length` function. This returns the number of
values in a data structure (the number of keys in a dictionary type).

