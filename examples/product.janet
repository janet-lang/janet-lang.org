# product over byte values [0-255] in a bytes type
(product "hello") # -> 13599570816
(product @"") # -> 1

(product @[1 2 3]) # -> 6
(product [2 3 5 7 11 13 17 19]) # -> 9699690
(product (range 1 10)) # -> 362880
(product []) # -> 1

# product over values in a dictionary
(product {:a 1 :b 2 :c 3}) # -> 6
(product @{0 -1 1 0 2 1}) # -> 0

(product (coro (yield 1) (yield 2) (yield 3))) # -> 6
