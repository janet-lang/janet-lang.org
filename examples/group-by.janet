(group-by |(< $ (chr "m")) "abxy") # -> @{false @[120 121] true @[97 98]}

(group-by type [0 1 nil]) # -> @{:nil @[nil] :number @[0 1]}

(group-by identity @{:a 97 :y true}) # -> @{97 @[97] true @[true]}

(group-by zero? (coro (yield 0) (yield 11))) # -> @{false @[11] true @[0]}
