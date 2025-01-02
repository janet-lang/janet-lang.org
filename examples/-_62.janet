(-> {:a [1 2 3] :b [4 5 6]}
    (get :a)
    (sum)
    ((fn [x y] (/ x y)) 2)) # The 6 from the sum is threaded first and binds to x, then 2 binds to y.
# -> 3
