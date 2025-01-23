(distinct @[1 2 3 2 1]) # -> @[1 2 3]

(distinct [1 2 3 2 1]) # -> @[1 2 3]

(distinct "bookkeeper") # -> @[98 111 107 101 112 114]

(sort (map string/from-bytes (distinct "bookkeeper"))) # -> @["b" "e" "k" "o" "p" "r"]