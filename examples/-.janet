(-) # -> 0
(- 10) # -> -10
(- 1 2) # -> -1
(- 1.4 -4.5) # -> 5.9

(- 1 2 3 4 5 6 7 8 9 10) # -> -53
(def nums (range 1 11)) # -> @[1 2 3 4 5 6 7 8 9 10]
(def frst (first nums)) # -> 1
(def rest (slice nums 1)) # -> [2 3 4 5 6 7 8 9 10]
(- frst (+ ;rest)) # -> -53

# can subtract types that support the :- or :r- method
(- (int/s64 "10") 10) # -> <core/s64 0>
