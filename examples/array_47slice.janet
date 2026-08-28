# using non-negative `start` and `end` arguments
(array/slice @[:a :b :c] 0 2) # -> @[:a :b]
(array/slice @[:a :b :c] 1 3) # -> @[:b :c]

# only non-negative `start` argument
(array/slice @[:a :b :c] 0) # -> @[:a :b :c]
(array/slice @[:a :b :c] 1) # -> @[:b :c]
(array/slice @[:a :b :c] 3) # -> @[]

# errors since `start` is out of bounds
(array/slice @[:a :b :c] 4)

# not using `start` / `end` duplicates array
(array/slice @[:a :b :c]) # -> @[:a :b :c]

# only negative `start` argument
(array/slice @[:a :b :c] -1) # -> @[]
(array/slice @[:a :b :c] -2) # -> @[:c]
(array/slice @[:a :b :c] -4) # -> @[:a :b :c]

# errors since `start` is out of bounds
(array/slice @[:a :b :c] -5)

# both `start` and `end` negative
(array/slice @[:a :b :c] -4 -1) # -> @[:a :b :c]
(array/slice @[:a :b :c] -4 -3) # -> @[:a]
(array/slice @[:a :b :c] -4 -4) # -> @[]

# errors since `end` is out of bounds
(array/slice @[:a :b :c] -4 -5)
