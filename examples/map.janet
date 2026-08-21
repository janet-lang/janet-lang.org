(map identity @"lol") # -> @[108 111 108]

# inc is applied to every value of the input
(map inc [7 8 9]) # -> @[8 9 10]

# variadic
(map array [:x :y] [-1 1]) # -> @[@[:x -1] @[:y 1]]

# result array has length of the shortest input
(map |(pos? (+ ;$&)) [1 2 3] [-1 -2 -3] [0 1]) # -> @[false true]

# value order for dictionaries is unspecified
(sort (map math/abs {:a -1 :b -2})) # -> @[1 2]

(map inc (coro (yield 7) (yield 8) (yield 9))) # -> @[8 9 10]
