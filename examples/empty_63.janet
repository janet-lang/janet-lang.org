(empty? []) # -> true

(empty? [1]) # -> false

(empty? @[]) # -> true

(empty? @{}) # -> true

(empty? "") # -> true

(empty? 0) # -> error: expected iterable type, got 0