# using non-negative `start` and `end` arguments
(string/slice "abc" 0 2) # -> "ab"
(string/slice "abc" 1 3) # -> "bc"
(string/slice :abc 1 3) # -> "bc"
(string/slice 'abc 1 3) # -> "bc"
(string/slice @"abc" 1 3) # -> "bc"

# only non-negative `start` argument
(string/slice "abc" 0) # -> "abc"
(string/slice "abc" 1) # -> "bc"
(string/slice "abc" 3) # -> ""

# errors since `start` is out of bounds
(string/slice "abc" 4)

# not using `start` / `end` duplicates array
(string/slice "abc") # -> "abc"

# only negative `start` argument
(string/slice "abc" -1) # -> ""
(string/slice "abc" -2) # -> "c"
(string/slice "abc" -4) # -> "abc"

# errors since `start` is out of bounds
(string/slice "abc" -5)

# both `start` and `end` negative
(string/slice "abc" -4 -1) # -> "abc"
(string/slice "abc" -4 -3) # -> "a"
(string/slice "abc" -4 -4) # -> ""

# errors since `end` is out of bounds
(string/slice "abc" -4 -5)
