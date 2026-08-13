(def buf @"zyx")
(sort-by |(* $ $) buf) # -> @"xyz"
buf # -> @"xyz"

(def arr @[-2 -1 -0])
(sort-by math/abs arr) # -> @[0 -1 -2]
arr # -> @[0 -1 -2]
