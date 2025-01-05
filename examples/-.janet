(-) # -> 0
(- 10) # -> -10
(- 1 2) # -> -1
(- 1.4 -4.5) # -> -5.9

# Equivalent to (- first (+ ;rest))
(- 1 2 3 4 5 6 7 8 9 10) # -> -53

# Janet can subtract types that support the :- or :r- method
(- (int/s64 "10") 10) # -> <core/s64 0>
