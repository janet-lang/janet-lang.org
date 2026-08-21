# sum over bytes values [0-255] in a bytes type
(sum "hello") # -> 532
(sum @"") # -> 0

(sum @[1]) # -> 1
(sum @[2 3 5 7 11 13 17 19]) # -> 77
(sum (range 100)) # -> 4950
(sum []) # -> 0

# sum over values in a dictionary
(sum {:a 1 :b 2 :c 3}) # -> 6
(sum @{0 -1 1 0 2 1}) # -> 0

(sum (coro (yield 1) (yield 2) (yield 3))) # -> 6
