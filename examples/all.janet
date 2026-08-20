(all |(< $ (chr "m")) "abc") # -> true

(all pos? [1 2 3]) # -> true
(all pos? [1 2 -3]) # -> false
(all truthy? @[1 2 nil]) # -> false
(all neg? @[]) # -> true

# variadic
(all (fn [x y] (pos? (* x y))) [-1 2] [-2 1]) # -> true

# predicate may not be applied to all values (e.g. 43)
(all |(neg? (+ $0 $1 $2)) [-2 2] [1 -8] [0 1 43]) # -> true

(all even? {:a 2 :b 8 :c 20}) # -> true

(all pos? (coro (yield 1) (yield 2))) # -> true
