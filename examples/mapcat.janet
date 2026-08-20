(mapcat |(- $ 99) @"abcde") # -> @[-2 -1 0 1 2]

# consolidate with array/concat after applying identity to each
(mapcat identity [[-2 -1] [0 1 2] [7 8]]) # -> @[-2 -1 0 1 2 7 8]

# variadic
(mapcat tuple [:x :y] [-1 1]) # -> @[:x -1 :y 1]

# function may not be applied to all values (i.e. :z)
(mapcat |(tuple $0 $1 $2) [:a :b] [:x :y :z] [0 1]) # -> @[:a :x 0 :b :y 1]

# value order for dictionaries is unspecified
(sort (mapcat identity @{:a [-2 -1] :b [0 1]:c [2]})) # -> @[-2 -1 0 1 2]

(mapcat identity (coro (yield [-2 -1]) (yield [0 1]))) # -> @[-2 -1 0 1]
