(def buf @"ahola")
(reverse! buf) # -> @"aloha"
buf # -> @"aloha"

(def arr @[2 3 5 7])
(reverse! arr) # -> @[7 5 3 2]
arr # -> @[7 5 3 2]
