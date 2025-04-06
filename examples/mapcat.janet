# consolidate with array/concat after applying identity to each
(mapcat identity [[-2 -1] [0 1 2] [7 8]]) # -> @[-2 -1 0 1 2 7 8]

# multiple data structures can be handled
(mapcat tuple [:x :y] [-1 1]) # -> @[:x -1 :y 1]

# function may not be applied to all values (e.g. :z)
(mapcat |(tuple $0 $1 $2) [:a :b] [:x :y :z] [0 1]) # -> @[:a :x 0 :b :y 1]

