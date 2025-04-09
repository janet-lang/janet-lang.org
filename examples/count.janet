# total of values for which pos? results in truthy value
(count pos? [math/-inf -1 0 1 math/pi]) # -> 2

# multiple data structures can be handled
(count (fn [x y] (neg? (+ x y))) [-1 -1 -1] [-1 0 1]) # -> 2

# predicate may not be applied to all values (e.g. 99)
(count |(pos? (* $0 $1 $2)) [-3 -2] [-1 0 99] [3 2]) # -> 1

