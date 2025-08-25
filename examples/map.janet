# inc is applied to every value of the input data structure
(map inc [7 8 9]) # -> @[8 9 10]

# multiple data structures can be handled
(map array [:x :y] [-1 1]) # -> @[@[:x -1] @[:y 1]]

# result array has length of the shortest input data structure
(map |(pos? (+ ;$&)) [1 2 3] [-1 -2 -3] [0 1]) # -> @[false true]

