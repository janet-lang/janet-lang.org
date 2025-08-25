(product []) # -> 1
(product @[1 2 3]) # -> 6
(product [0 1 2 3]) # -> 0
(product (range 1 10)) # -> 362880

# Product over byte values [0-255] in a string
(product "hello") # -> 13599570816

# Product over values in a table or struct
(product {:a 1 :b 2 :c 4}) # -> 8
