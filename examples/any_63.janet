(any? "lol") # -> 108
(any? @"") # -> nil

(any? [nil nil false]) # -> false
(any? @[nil :goose nil]) # -> :goose
(any? @[]) # -> nil

(any? {:a true :b false}) # -> true

(any? (coro (yield false) (yield true) (yield :apple))) # -> true
