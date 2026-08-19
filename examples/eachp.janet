(def arr @[])
(eachp p "hello" (array/push arr p)) # -> nil
arr # ->   @[[0 104] [1 101] [2 108] [3 108] [4 111]]

# keys for tuples / arrays are 0-based index
# prints 0->:a 1->:b 2->:c 3->:d 4->:e
(eachp [i x] [:a :b :c :d :e] (prinf "%v->%v " i x)) # -> nil

# key, value from table/struct in an unspecified order
# prints :b -> 2 :a -> 1
(eachp [k v] {:a 1 :b 2} (prinf "%v -> %v " k v)) # -> nil

(def arr @[])
(eachp [i [j k]] {0 [1 2] 7 [8 9]} (array/push arr [j i k])) # -> nil
(sort arr) # -> @[[1 0 2] [8 7 9]]
