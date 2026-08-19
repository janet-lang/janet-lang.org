(reduce2 + "hi") # ->  209
(accumulate2 + "hi") # -> @[104 209]

(reduce2 - @"") # -> nil
(accumulate2 - @"") # -> @[]

(reduce2 + [1 2 3]) # -> 6
(accumulate2 + [1 2 3]) # -> @[1 3 6]

(reduce2 + []) # -> nil
(accumulate2 + []) # -> @[]

(reduce2 max [1 2 3 9 5]) # -> 9
(accumulate2 max [1 2 3 9 5]) # -> @[1 2 3 9 9]

(accumulate2 * {:a 1 :b 2 :c 4}) # -> @[2 8 8]

(accumulate2 * (coro (yield 4) (yield 2) (yield 1))) # -> @[4 8 8]
