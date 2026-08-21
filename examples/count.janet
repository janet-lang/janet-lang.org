(count |(= (chr "l") $) "lol") # -> 2

# total of values for which pos? results in truthy value
(count pos? [math/-inf -1 0 1 math/pi]) # -> 2

# variadic
(count (fn [x y] (neg? (+ x y))) [-1 -1 -1] [-1 0 1]) # -> 2

# predicate may not be applied to all values (i.e. 99)
(count |(pos? (* $0 $1 $2)) [-3 -2] [-1 0 99] [3 2]) # -> 1

(count odd? @{:x -1 :y 0 :z 3}) # -> 2

(count neg? (coro (yield -8) (yield 0))) # -> 1
