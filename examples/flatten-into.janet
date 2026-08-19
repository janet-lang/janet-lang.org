(flatten-into @[] [[:a :b] [[:c :d] :e]]) # -> @[:a :b :c :d :e]
(flatten-into @[] @[0 [1 [1]] [[2 [3 5]] 8]]) # -> @[0 1 1 2 3 5 8]
