(mean "oooooo") # -> 111
(nan? (mean "")) # -> true

(mean [110 111 111 111 112]) # -> 111

(mean @{:w 110 :x 111 :y 111 :z 112}) # -> 111

(mean (coro (yield 110) (yield 111) (yield 112))) # -> 111
