(partition 2 "hello!") # -> @["he" "ll" "o!"]
(partition 3 @"hello!") # -> @["hel" "lo!"]
(partition 4 'hello!) # -> @["hell" "o!"]
(partition 5 :hello!) # -> @["hello" "!"]

(partition 1 [:ant :bee :cat]) # -> @[[:ant] [:bee] [:cat]]
(partition 3 @['rck 'ppr 'scssrs 'spck]) # -> @[['rck 'ppr 'scssrs] ['spck]]

(partition 2 (coro (yield 0) (yield 1) (yield 2))) # -> @[[0 1] [3]]
