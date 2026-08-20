(every? "hello") # -> 111
(every? @"") # -> true

(every? [true 'truer nil 'truest]) # -> nil
(every? @[-2 -1 0]) # -> 0
(every? @[]) # -> true

(every? {:a true :b false}) # -> false

(every? (coro (yield true) (yield false) (yield :apple))) # -> false
