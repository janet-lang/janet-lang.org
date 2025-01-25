(slice @[1 2 3]) # -> (1 2 3)
(slice @[:a :b :c] 1) # -> (:b :c)
(slice [:a :b :c :d :e] 2 4) # -> (:c :d)
(slice [:a :b :c :d :e] 2 -1) # -> (:c :d :e)
(slice [:a :b :c :d :e] 2 -2) # -> (:c :d)
(slice [:a :b :c :d :e] 2 -4) # -> ()
(slice [:a :b :c :d :e] 2 -10) # -> error: end index -10 out of range [-6,5]
(slice "abcdefg" 0 2) # -> "ab"
(slice @"abcdefg" 0 2) # -> "ab"

