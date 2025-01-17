(all pos? [1 2 3]) # -> true
(all pos? [1 2 -3]) # -> false

(all pos? []) # -> true
(all neg? []) # -> true

(all truthy? [1 2 3]) # -> true
(all truthy? [1 2 nil]) # -> false
