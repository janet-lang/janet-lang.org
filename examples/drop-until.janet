(drop-until neg? [1 2 3 0 -4 5 6]) # -> (-4 5 6)

(drop-until |(< (length $) 3) ["hello" "goodbye" "hi"]) # -> ("hi")

# returns input if first element passes pred
(drop-until pos? [1 2 3 0 -4 5 6]) # -> (1 2 3 0 -4 5 6)

# compares elements as bytes and returns a string
(drop-until |(> 65 $) "foo01bar") # -> "01bar"
(drop-until |(> "A" (string/from-bytes $)) "foo01bar") # -> "01bar"
