(values "xyz") # -> @[120 121 122]
(values 'abc) # -> @[97 98 99]

(values ['tom 'dick 'harry]) # -> @['tom 'dick 'harry]
(values @['anne 'jane 'mary]) # -> @['anne 'jane 'mary]

(sort (values {0 :ant 1 :bee 2 :cat})) # -> @[:ant :bee :cat]
(sort (values @{:a 1 :b 2 :c 3})) # -> @[1 2 3]

(values (coro (yield :zero) (yield :one))) # -> @[:zero :one]
