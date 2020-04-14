(sum []) # -> 0
(sum @[1]) # -> 1
(sum (range 100)) # -> 5050

# Sum over bytes values [0-255] in a string
(sum "hello") # -> 532

# Sum over values in a table or struct
(sum {:a 1 :b 2 :c 4}) # -> 7
