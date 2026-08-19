(update-in @[[0 1] @[2 3]] [1 0] |(+ $0 $1) 9) # -> @[[0 1] @[11 3]]
(update-in @[[0 1] @[]] @[1 0] |(if $0 0 $1) 8) # -> @[[0 1] @[8]]

(update-in @{:a @{:b 2}} [:a :b] inc) # -> @{:a @{:b 3}}
(update-in @{} [:x :y] |(do $1) :z) # -> @{:x @{:y :z}}
(update-in @{:a @{}} [:a :b] |(if $ :yeah :nope)) # -> @{:a @{:b :nope}}
(update-in @{:x @[]} [:x 0] |(do $1) :treasure) # -> @{:x @[:treasure]}
