(reduce + 0 [1 2 3 4]) # -> 10
(accumulate + 0 [1 2 3 4]) # -> @[1 3 6 10]

(reduce + 0 []) # -> 0
(accumulate + 0 []) # -> @[]

(reduce string "" ["J" "a" "n" "e" "t"]) # -> "Janet"
(accumulate string "" ["J" "a" "n" "e" "t"]) # -> @["J" "Ja" "Jan" "Jane" "Janet"]
