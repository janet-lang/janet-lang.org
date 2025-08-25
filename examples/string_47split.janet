# substrings split by delimiter
(string/split "," "x,y,z") # -> @["x" "y" "z"]

# delimiter not found so result has one element
(string/split "!" "1 2 3") # -> @["1 2 3"]

# start searching part-way through
(string/split "," "a,e,i,o" 3) # -> @["a,e" "i" "o"]

# limit number of results
(string/split ";" "a;b;c;d;e" 0 3) # -> @["a" "b" "c;d;e"]

# delimiter should be non-empty
(string/split "" "word") # -> error: expected non-empty pattern

