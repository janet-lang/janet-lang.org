(frequencies "all") # -> @{97 1 108 2}
(frequencies @"all") # -> @{97 1 108 2}
(frequencies 'lol) # -> @{108 2 111 1}
(frequencies :lol) # -> @{108 2 111 1}

(frequencies [:duck :duck :duck :goose]) # -> @{:duck 3 :goose 1}
(frequencies @[2 7 1 8 2 8 1 8]) # -> @{1 2 2 2 7 1 8 3}

(frequencies {1 :a 2 :x 3 :x 8 :a}) # -> @{:a 2 :x 2}
(frequencies @{}) # -> @{}

(frequencies (coro (yield 1) (yield 8) (yield 8))) # -> @{1 1 8 2}
