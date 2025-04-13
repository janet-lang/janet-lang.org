# pos? yielded only falsey values, so nil returned
(some pos? [math/-inf 0]) # -> nil

# first truthy result encountered is returned
(some (fn [x] (when (pos? x) x)) [1 0 -1]) # -> 1

# input data structure is empty, so nil returned
(some pos? []) # -> nil

# multiple data structures can be handled
(some (fn [x y] (neg? (* x y))) [1 1] [1 -2]) # -> true

# predicate not always called with all values (e.g. 0)
(some |(zero? (* $0 $1 $2)) [1 2] [7 8] [-2 -1 0]) # -> nil

# one of the input data structures was empty, so nil returned
(some |(pos? (+ $0 $1 $2)) [1 2 3] [7 8 9] []) # -> nil

