(keep identity @"abc") # -> @[97 98 99]

# returns an array of truthy results of predicate
(keep identity [false :x nil true]) # -> @[:x true]

# keep values > 1, equivalent to filter
(keep (fn [x] (when (> x 1) x)) @[0 1 2 3]) # -> @[2 3]

# for all members > 2, keep the square
(keep (fn [x] (when (> x 2) (* x x))) [0 1 3 4 5]) # -> @[9 16 25]

# variadic
(keep |(when (pos? (+ $0 $1)) $0) [1 2 3] [-1 1 1]) # -> @[2 3]

# result length <= shortest of variadic args (i.e. [-1 1])
(keep |(when (neg? (* $0 $1)) $0) [-1 -2 -3] [-1 1]) # -> @[-2]

# value order for dictionaries is unspecified
(sort (keep |(+ 7 $) {:a 1 :b 2 :c 3})) # -> @[8 9 10]

(keep |(* -1 $) (coro (yield 0) (yield 1) (yield 2))) # -> @[0 -1 -2]
