# what counts as updating a table?

(def t1 @{:a 1})
(def t2 (table/clone t1))

# 1. adding a key-value pair
(put t1 :b 2) # -> @{:a 1 :b 2}

# t2 unaffected
t2 # -> @{:a 1}

# 2. removing a key-value pair
(put t1 :a nil) # -> @{:b 2}

# t2 unaffected
t2 # -> @{:a 1}

# 3. changing a key-value pair's value
(put t1 :a 0) # -> @{:a 0 :b 2}

# t2 unaffected
t2 # -> @{:a 1}


# what isn't updating a table?

(def arr @[:x])
# tables are a collection of key-value pairs
(def t1 @{:a arr})
(def t2 (table/clone t1))

# t1 and t2 have key-value pairs with values that are the same
(= (get t1 :a) (get t2 :a)) # -> true

# the key-value pairs' values are all the same array
(= (get t1 :a) (get t2 :a) arr) # -> true

# this does not count as updating t1 or t2
(array/push arr :y) # -> arr

# the value of each table's key-value pair is still arr, i.e. the
# tables have not been updated.
(= (get t1 :a) (get t2 :a) arr) # -> true

# each table's key-value pair is arr, which now has another element
(get t1 :a) # -> @[:x :y]
(get t2 :a) # -> @[:x :y]
