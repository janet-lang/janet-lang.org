(drop-while pos? [1 2 3 0 -4 5 6]) # -> (0 -4 5 6)

(drop-while |(> (length $) 3) ["hello" "goodbye" "hi"]) # -> ("hi")

# returns input if first element passes pred
(drop-while neg? [1 2 3 0 -4 5 6]) # -> (1 2 3 0 -4 5 6)

# compares elements as bytes and returns a string
(drop-while |(< 65 $) "foo01bar") # -> "01bar"
(drop-while |(< "A" (string/from-bytes $)) "foo01bar") # -> "01bar"
