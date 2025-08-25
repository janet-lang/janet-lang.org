# keys for tuple/array are 0-based index
# prints 0->:a 1->:b 2->:c 3->:d 4->:e
(eachp [i x] [:a :b :c :d :e] (prinf "%v->%v " i x)) # -> nil

# prints 0->"a" 1->"b" 2->"c" 3->"d" 4->"e"
(eachp [i x] @["a" "b" "c" "d" "e"] (prinf "%v->%v " i x)) # -> nil

# key, value from table/struct in an unspecified order
# prints :b -> 2 :a -> 1
(eachp [k v] {:a 1 :b 2} (prinf "%v -> %v " k v)) # -> nil

# prints :foo -> "A" :bar -> "B"
(eachp [k v] @{:foo "A" :bar "B"} (prinf "%v -> %v " k v)) # -> nil
