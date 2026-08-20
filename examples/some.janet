(some |(< (chr "a") $) @"bcd") # -> true

# pos? yielded only falsey values, so nil returned
(some pos? [math/-inf 0]) # -> nil

# first truthy result encountered is returned
(some (fn [x] (when (pos? x) x)) [1 0 -1]) # -> 1

# input is empty, so nil returned
(some pos? []) # -> nil

# variadic
(some (fn [x y] (neg? (* x y))) [1 1] [1 -2]) # -> true

# predicate not always called with all values (i.e. 0)
(some |(zero? (* $0 $1 $2)) [1 2] [7 8] [-2 -1 0]) # -> nil

# one of the inputs was empty, so nil returned
(some |(pos? (+ $0 $1 $2)) [1 2 3] [7 8 9] []) # -> nil

(some neg? {:a -1 :b 1}) # -> true

(some even? (coro (yield 1) (yield 3) (yield 8))) # -> true
