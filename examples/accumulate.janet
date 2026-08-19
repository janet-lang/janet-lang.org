(accumulate + 0 "xyz") # -> @[120 241 363]

(accumulate + 0 [1 2 3]) # -> @[1 3 6]

(accumulate + 0 []) # -> @[]

(accumulate string "" @["J" "a" "n"]) # -> @["J" "Ja" "Jan"]

(accumulate * 1 {:a -1 :b 2 :c -3}) # -> @[2 -6 6]

(accumulate + 0 (coro (yield 1) (yield 2) (yield 3))) # -> @[1 3 6]
