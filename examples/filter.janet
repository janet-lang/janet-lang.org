(filter pos? [1 2 3 0 -4 5 6]) # -> @[1 2 3 5 6]

(filter |(> (length $) 3) ["hello" "goodbye" "hi"]) # -> @["hello" "goodbye"]

(filter |(< (chr "A") $) "foo01bar") # -> @[102 111 111 98 97 114]

(string/from-bytes ;(filter |(< (chr "A") $) "foo01bar")) # -> "foobar"