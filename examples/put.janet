(put @"jam" 0 100) # -> @"dam"
(put @"" 1 100) # -> @"\0d"

(put @[:a :B :c] 1 :b) # -> @[:a :b :c]
(put @[] 2 :c) # -> @[nil nil :c]

(put @{:length 10 :width 20} :length 20) # -> @{:length 20 :width 20}
(put (table/setproto @{:a 1} @{:b 3}) :b 2) # -> @{:a 1 :b 2}
(put @{:error :many} :error nil) # -> @{}
