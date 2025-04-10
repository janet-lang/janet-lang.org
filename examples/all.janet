(all pos? [1 2 3]) # -> true
(all pos? [1 2 -3]) # -> false

(all pos? []) # -> true
(all neg? []) # -> true

(all truthy? [1 2 3]) # -> true
(all truthy? [1 2 nil]) # -> false

# multiple data structures can be handled
(all (fn [x y] (pos? (* x y))) [-1 2] [-2 1]) # -> true

# predicate may not be applied to all values (e.g. 43)
(all |(neg? (+ $0 $1 $2)) [-2 2] [1 -8] [0 1 43]) # -> true

