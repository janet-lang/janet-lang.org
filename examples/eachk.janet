# keys for tuple/array are 0-based index
# prints 0 1 2 3 4
(eachk i [1 2 3 4 5] (prin i " "))

# prints 0 1 2 3 4
(eachk i @[1 2 3 4 5] (prin i " "))

# keys table/struct, but maybe not in order
# prints :b :a
(eachk k {:a 1 :b 2} (prinf "%v " k))

# prints :foo :bar
(eachk k @{:foo "A" :bar "B"} (prinf "%v " k))
