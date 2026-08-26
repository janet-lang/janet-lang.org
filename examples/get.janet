(get "hello" 2) # -> 108
(get @"hello" 2) # -> 108
(get 'hello 1) # -> 101
(get :hello 1) # -> 101
(get :hello 8) # -> nil
(get :hello 8 11) # -> 11

(get [:bill :ted] 1) # -> :ted
(get @[:ant :bee] 0) # -> :ant
(get @[:ant :bee] 2) # -> nil
(get @[:ant :bee] 2 :fox) # -> :fox

(get {:length 20 :width 30} :width) # -> 30
(get @{:x 5 :y 12} :y) # -> 12
(get @{:x 5 :y 12} :z) # -> nil
(get @{:x 5 :y 12} :z -1) # -> -1

(def fib (coro (yield :a) (yield :b)))
(get fib 0) # -> nil
(resume fib) # -> :a
(get fib 0) # -> :a
(get fib 0) # -> :a
(get fib 1 :oops) # -> :oops
(resume fib) # -> :b
(get fib 0) # -> :b
(resume fib) # -> nil
(get fib 0) # -> nil
