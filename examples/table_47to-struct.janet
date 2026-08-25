(table/to-struct @{:x 0}) # -> {:x 0}

# create a struct, specifying another struct as a prototype
(def st (table/to-struct @{:a 1} {:b 2}))
(type st) # -> :struct
(length st) # -> 1
(keys st) # -> @[:a]
(get st :a) # -> 1
(struct/getproto st) # -> {:b 2}
(get st :b) # -> 2

# the table's prototype is ignored when creating the new struct
(def tab @{:a 1})
(table/setproto tab @{:b 1})
(def st (table/to-struct tab))
(struct/getproto st) # -> nil
