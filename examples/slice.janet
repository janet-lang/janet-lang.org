(slice @[1 2 3]) # -> @[1 2 3] (a new array!)
(slice @[:a :b :c] 1) # -> @[:b :c]
(slice [:a :b :c :d :e] 2 4) # -> (:c :d)
(slice [:a :b :d :d :e] 2 -1) # -> (:c :d :e)
(slice [:a :b :d :d :e] 2 -2) # -> (:c :d)
(slice [:a :b :d :d :e] 2 -4) # -> ()
(slice [:a :b :d :d :e] 2 -10) # -> error: range error
(slice "abcdefg" 0 2) # -> "ab"
(slice @"abcdefg" 0 2) # -> "ab"

