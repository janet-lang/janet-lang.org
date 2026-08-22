(update @"hello" 0 (fn [old delta] (+ old delta)) 17) # -> @"yello"

(update @[:x :yy :z] 1 |(keyword (slice $ 0 1))) # -> @[:x :y :z]

(update @{:a 1 :b -1 :c 3} :b + 3) # -> @{:a 1 :b 2 :c 3}
