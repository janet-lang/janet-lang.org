(def arr @[])
(def str "lol")
(eachk i str (array/push arr [i (get str i)])) # -> nil
arr # -> @[[0 108] [1 111] [2 108]]

# keys for tuples / arrays are 0-based index
# prints 0 1 2 3 4
(eachk i [:a :b :c :d :e] (prin i " ")) # -> nil

# print keys in tables / structs in an unspecified order
# prints :b :a
(eachk k {:a 1 :b 2} (prinf "%v " k)) # -> nil

(def arr @[])
(eachk [_ j] {[:a 0] :x [:b 1] :y} (array/push arr j)) # -> nil
arr # -> @[0 1]
