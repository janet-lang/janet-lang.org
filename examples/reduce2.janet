(reduce2 + "hi") # -> 209
(reduce2 / @"") # -> nil

(reduce2 / [32 8 4]) # -> 1

(reduce2 * {:a 1 :b 2 :c 4}) # -> 8

(reduce2 * (coro (yield 4) (yield 2) (yield 1))) # -> 8
