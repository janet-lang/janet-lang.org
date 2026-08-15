(keys "grin") # -> @[0 1 2 3]

(keys @['alice 'bob 'eve]) # -> @[0 1 2]

(sort (keys {:a 1 :b 2})) # -> @[:a :b]
