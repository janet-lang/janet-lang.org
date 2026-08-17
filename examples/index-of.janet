(index-of (chr "_") "(^_^)") # -> 2
(index-of (chr "c") :keyword :empty-handed) # -> :empty-handed

(index-of :secret [:ant :bee :secret :rooster]) # -> 2
(index-of 21 @[0 1 1 2 3 5 8 13]) # -> nil

(index-of 2 {:a 1 :b 2}) # -> :b
(index-of :needle @{} :blank) # -> :blank

(index-of :x (struct/with-proto {:x 8} :a 1) :nope!) # -> :nope!

# every key in a fiber is 0
(index-of :x (coro (yield :x) (yield :y) (yield :z))) # -> 0
(index-of :y (coro (yield :x) (yield :y) (yield :z))) # -> 0
(index-of :z (coro (yield :x) (yield :y) (yield :z))) # -> 0
