(def buf @"")
(each b "hello" (buffer/push buf b)) # -> nil
buf # -> @"hello"

# prints 12345
(each y @[1 2 3 4 5] (prin y)) # -> nil

(def arr @[])
(each [_ [a b]] [[:x [0 1]] [:y [-1 0]]]
  (array/push arr b a)) # -> nil
arr # -> @[1 0 0 -1]

# prints values from struct in an unspecified order
# 21 -or- 12
(each x {:a 1 :b 2} (prin x)) # -> nil

(def arr @[])
(each [a b] @{:x [0 1] :y [-1 0]}
  (array/push arr a b)) # -> nil
(sort arr) # -> @[-1 0 0 1]

(def tab @{})
(each [k v] (coro (yield [0 1]) (yield [2 8]))
  (put tab v k)) # -> nil
tab # -> @{1 0 8 2}
