# as implemented, geomean can result in a numbers that are "almost"
# integers.  to make comparisons with integers, we use a helper
# function for check whether a difference from an integer value is
# "small" for some appropriately sized difference.
(defn small? [x] (< (math/abs x) 1e-13))
(small? 1e-14) # -> true
(small? 1e-12) # -> false

(small? (- 111 (geomean "oooooo"))) # -> true
(nan? (geomean "")) # -> true

(small? (- 9 (geomean [3 9 27]))) # -> true

(small? (- 16 (geomean @{:w 2 :x 8 :y 32 :z 128}))) # -> true

(small? (- 9 (geomean (coro (yield 27) (yield 9) (yield 3))))) # -> true
