{%
(def title "Tables")
(def description "The table is one of the most flexible data structures in Janet and
is modeled after the associative array, or dictionary. Values are
put into a table with a key, and can be looked up later with the
same key. Tables are implemented with an underlying open hash table, so
they are quite fast and cache friendly.")
(def prev-page {
 :link "/arrays.html"
 :text "Arrays"})
(def next-page {
 :link "/buffers.html"
 :text "Buffers"})
%}

The table is one of the most flexible data structures in Janet and
is modeled after the associative array, or dictionary. Values are
put into a table with a key, and can be looked up later with the
same key. Tables are implemented with an underlying open hash table, so
they are quite fast and cache friendly.

Any Janet value except nil and NaN can either a key or a value in a Janet
table, and a single Janet table can have any mixture of
types as keys and values.

## Creating Tables

The easiest way to create a table is via a table literal.

```janet
(def my-tab @{
 :key1 1
 "hello" "world!"
 1 2
 '(1 0) @{:another :table}})
```

Another way to create a table is via the `table` function. This has the advantage
that `table` is an ordinary function that can be passed around like any other. For
most cases, a table literal should be preferred.

```janet
(def my-tab (table
             :key1 1
             "hello" "world!"
             1 2
             '(1 0) @{:another :table}))
```

## Getting and Setting values

Like other data structures in Janet, values in a table can be retrieved
with the `get` function, and new values in a table can be added via the
`put` function or the `set` special. Inserting a value of nil into a table
removes the key from the table. This means table's cannot contain nil values.

```janet
(def t @{})

(get t :key) #-> nil

(put t :key "hello")
(get t :key) #-> "hello")

(set (t :cheese) :cake)
(get t :cheese) #-> :cake

# Tables can be called as functions
# that look up the argument
(t :cheese) #-> :cake
```

## Prototypes

All tables can have a prototype, a parent table that is checked when a
key is not found in the first table. By default, tables have no prototype.
Prototypes are a flexible mechanism that, among other uses, can be used to
implement inheritance in Janet. Read more in the [documentation for prototypes](/prototypes.html)

## Useful functions for tables

The Janet core library has many useful functions for manipulating tables. Below
is a non-exhaustive list.

* `frequencies`
* `keys`
* `kvs`
* `length`
* `merge-into`
* `merge`
* `pairs`
* `post-walk`
* `pre-walk`
* `table/getproto`
* `table/setproto`
* `update`
* `values`
* `walk`
* `zipcoll`

See the [Core Api Documentation](/doc.html) for more information on individual functions.
