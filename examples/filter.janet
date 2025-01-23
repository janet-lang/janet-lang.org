(filter pos? [1 2 3 0 -4 5 6]) # -> @[1 2 3 5 6]

(filter |(> (length $) 3) ["hello" "goodbye" "hi"]) # -> @["hello" "goodbye"]

(filter |(< 65 $) "foo01bar") # -> @[102 111 111 98 97 114]

(string/join
 (map string/from-bytes 
      (filter |(< "A" (string/from-bytes $)) "foo01bar"))) # -> "foobar"