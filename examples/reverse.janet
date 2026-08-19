(reverse "abcdef") # -> @"fedcba"

(reverse [1 2 3]) # -> @[3 2 1]

(reverse (coro (yield :ant) (yield :bee))) # -> @[:bee :ant]
