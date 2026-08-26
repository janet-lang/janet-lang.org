(in "hello" 2) # -> 108
(in @"hello" 2) # -> 108
(in 'hello 3) # -> 108
(in :hello 3) # -> 108
# errors since key out of bounds
(in :hello 8)
# errors since key out of bounds
(in :hello 8 11)
# errors since key not integer
(in :hello :key)

(in [:bill :ted] 1) # -> :ted
(in @[:ant :bee] 0) # -> :ant
# errors since key out of bounds
(in @[:ant :bee] 2)
# errors since key out of bounds
(in @[:ant :bee] 2 :fox)
# errors since key not integer
(in @[:ant :bee] :key)

(in {:length 20 :width 30} :width) # -> 30
(in @{:x 5 :y 12} :y) # -> 12
(in @{:x 5 :y 12} :z) # -> nil
(in @{:x 5 :y 12} :z -1) # -> -1

(def fib (coro (yield :a) (yield :b)))
(in fib 0) # -> nil
(resume fib) # -> :a
(in fib 0) # -> :a
(in fib 0) # -> :a
# errors since unexpected key
(in fib 1 :oops)
(resume fib) # -> :b
(in fib 0) # -> :b
(resume fib) # -> nil
(in fib 0) # -> nil
