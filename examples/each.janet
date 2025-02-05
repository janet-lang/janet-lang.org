# prints 12345
(each x [1 2 3 4 5] (prin x)) # -> nil

# prints 12345
(each y @[1 2 3 4 5] (prin y)) # -> nil

# prints values from struct in an unspecified order
# 21 -or- 12
(each x {:a 1 :b 2} (prin x)) # -> nil
