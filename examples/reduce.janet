(reduce + 0 "xyz") # -> 363
(reduce array/push @[] :xyz) # -> @[120 121 122]
(reduce |(buffer/push-byte $0 $1 (chr "|")) @"|" 'xyz) # -> @"|x|y|z|"

(reduce merge-into @{} [{:a 1} {:b 2}]) # -> @{:a 1 :b 2}
(reduce buffer/push @"" @[:mar :ma :lade]) # -> @"marmalade"

(reduce * 1 {:a -1 :b 2 :c -3}) # -> 6
(reduce |(merge-into $0 @{$1 1}) @{} @{0 :a 1 :b}) # -> @{:a 1 :b 1}

(reduce + 0 (coro (yield 1) (yield 2) (yield 3))) # -> 6
