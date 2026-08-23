(interleave "ab" "ij" "xy") # -> @[97 105 120 98 106 121]
(interleave :abc :ij :x) # -> @[97 105 120]

(interleave [0 :a] [1 :b] [2 :c]) # -> @[0 1 2 :a :b :c]
(interleave @[0 1 2] @[7 8] @[9]) # -> @[0 7 9]

(interleave (coro (yield 0) (yield :a))
            (coro (yield 1) (yield :b))) # -> @[0 1 :a :b]
