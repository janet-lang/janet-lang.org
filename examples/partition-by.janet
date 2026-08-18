(partition-by even? "lol!") # -> @[@[108] @[111] @[108] @[33]]
(partition-by |(< 100 $) @"lol!") # -> @[@[108 111 108] @[33]]
(partition-by identity 'lol!) # -> @[@[108] @[111] @[108] @[33]]
(partition-by neg? :lol!) # -> @[@[108 111 108 33]]

(partition-by keyword? [:a "b" 'c]) # -> @[@[:a] @["b" 'c]]

(partition-by |(has-value? $ (chr "x"))
              @['sox 'ox 'docs]) # -> @[@['sox ox] @['docs]]

(partition-by pos? (coro (yield 1) (yield -1))) # -> @[@[1] @[-1]]
