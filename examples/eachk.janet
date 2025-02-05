# keys for tuple/array are 0-based index
# prints 0 1 2 3 4
(eachk i [:a :b :c :d :e] (prin i " "))

# prints 0 1 2 3 4
(eachk i @["a" "b" "c" "d" "e"] (prin i " "))

# prints keys in table/struct in an unspecified order
# prints :b :a
(eachk k {:a 1 :b 2} (prinf "%v " k))

# prints :foo :bar
(eachk k @{:foo "A" :bar "B"} (prinf "%v " k))
