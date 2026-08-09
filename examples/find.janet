(find |(= $ (chr "o")) "tomato") # -> 111
(find |(= $ (chr "m")) "potato") # -> nil
(find |(> $ (chr "y")) :ant :surprise) # -> :surprise
(find |(< (chr "a") $ (chr "k")) 'lynx) # -> nil

(find pos? [-1 0 11]) # -> 11
(find neg? @[0 1 2 3 5]) # -> nil

(find one? {:a 1 :b 2}) # -> 1
(find even? @{:x 11 :y 28 :z 33}) # -> 28

(find keyword? (coro (yield 'jump) (yield :wave))) # -> :wave
