(get-in [[0 1] [2 3]] [1 0]) # -> 2
(get-in [[0 1] [2 3]] [1 2] :missed!) # -> :missed!
(get-in [[0 1] [2 3]] @[1 0]) # -> 2

(get-in {:a {:b 1}} [:a :b]) # -> 1
(get-in {:a {:b 1}} @[:a :b]) # => 1
(get-in {:a {:b 1}} @[:a :c] :oops) # -> :oops
