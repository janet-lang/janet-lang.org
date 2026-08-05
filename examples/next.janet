(next "hi") # -> 0
(next "hi" 0) # -> 1
(next "hi" 1) # -> nil
(next @"hello" 2) # -> 3
(next 'hello 3) # -> 4
(next :hello 4) # -> nil

(next [:bill :ted] 0) # -> 1
(next @[:ant :bee] 0) # -> 1
(next @[:ant :bee] 1) # -> nil

(next {:length 20 :width 30}) # -> :length or :width
(next @{:x 5 :y 12}) # -> :x or :y
(next @{:x 5 :y 12} :x) # -> :y or nil
(next @{:x 5 :y 12} :y) # -> :x or nil

(def fib (coro (yield :a) (yield :b)))
(next fib) # -> 0
(next fib) # -> 0
(next fib) # -> nil

