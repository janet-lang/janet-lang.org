(length "hello") # -> 5
(length @"안녕") # -> 6
(length 'length) # -> 6
(length :) # -> 0

(length [:highlander]) # -> 1
(length @[3 1 4 1 5 9 2 6 5 3 5]) # -> 11

(length {:a 1 :b 2}) # -> 2
(length @{:apollo :apollo :artemis :diana :hermes :mercury}) # -> 3

(length (struct/with-proto {:a 1} :B 2)) # -> 1
