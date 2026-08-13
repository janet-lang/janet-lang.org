(def buf @"zyx")
(sort buf) # -> @"xyz"
buf # ->  @"xyz"
(sort buf >) # -> @"zyx"
buf # ->  @"zyx"

(def arr @[2 1 0])
(sort arr) # -> @[0 1 2]
arr # -> @[0 1 2]
(sort arr >) # -> @[2 1 0]
arr # -> @[2 1 0]
