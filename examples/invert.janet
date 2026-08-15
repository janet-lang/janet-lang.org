(invert "hi") # -> @{104 0 105 1}
(invert @"all") # -> @{97 0 108 2}

(invert [:a :b :c]) # -> @{:a 0 :b 1 :c 2}
(invert @[0 0 0]) # -> @{0 2}

(invert {:x 1 :y 2}) # -> @{1 :x 2 :y}
(invert @{:a 1 :b 1}) # -> @{1 :a}
