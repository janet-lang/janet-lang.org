# keys for tuple/array are 0-based index
# prints 0->1 1->2 2->3 3->4 4->5
(eachp [i x] [1 2 3 4 5] (prin i "->" x " "))

(eachp [i x] @[1 2 3 4 5] (prin i "->" x " "))

# key, value from table/struct, but maybe not in order
# prints :b -> 2 :a -> 1
(eachp [k v] {:a 1 :b 2} (prinf "%v -> %v " k v))

# prints :foo -> "A" :bar -> "B"
(eachp [k v] @{:foo "A" :bar "B"} (prinf "%v -> %v " k v))
