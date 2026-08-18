(interpose ":" "hello") # -> @[104 ":" 101 ":" 108 ":" 108 ":" 111]

(interpose 0 [1 2 3]) # -> @[1 0 2 0 3]

(interpose :duck (coro (yield :duck) (yield :goose))) # -> @[:duck :duck :goose]
