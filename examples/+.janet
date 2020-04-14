(+) # -> 0
(+ 10) # -> 10
(+ 1 2) # -> 3
(+ 1.4 -4.5) # -> -3.1
(+ 1 2 3 4 5 6 7 8 9 10) # -> 55

# Splice can be used to sum arrays, but 'sum' is better
(+ ;(range 101)) # -> 5050
(sum (range 101)) # -> 5050

# Janet can add types that support the :+ or :r+ method
(+ (int/s64 "10") 10) # -> <core/s64 20>

# Bad types give errors
(+ nil 10) # -> error: could not find method :+ for nil, or :r+ for 10
