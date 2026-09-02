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

# a table is a collection of associated keys and values
(def key :a)
(def val @[:x])
(def t1 @{key val})
(def t2 (table/clone t1))

# the value associated with key is the same in both tables
(= (get t1 key) (get t2 key)) # -> true

# in particular, the value is val, a specific array
(= (get t1 key) (get t2 key) val) # -> true

# adding an element, :y, to val does NOT count as updating the tables
(array/push val :y) # -> val

# the value associated with key in each table is still val, i.e. the
# tables have not been updated.
(= (get t1 key) (get t2 key) val) # -> true

# val has an additional element, :y
val # -> @[:x :y]

# accessing val from t1 and t2
(get t1 key) # -> @[:x :y]
(get t2 key) # -> @[:x :y]
