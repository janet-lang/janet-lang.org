# keep values > 1, equivalent to filter
(keep (fn [x] (when (> x 1) x)) @[0 1 2 3]) # -> @[2 3]

# for all members > 2, keep the square
(keep (fn [x] (when (> x 2) (* x x))) [0 1 3 4 5]) # -> @[9 16 25]

# operates on values in table
(keep (fn [x] (when (> x 1) (* x x))) @{:foo 1 :bar 2 :baz 3}) # -> @[4 9]