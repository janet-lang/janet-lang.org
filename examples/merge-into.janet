(merge-into @{:a 1} {:b 2}) # -> @{:a 1 :b 2}
(merge-into @{} @{:y 20} @{:x 20}) # -> @{:x 20 :y 20}
(merge-into @{} @{:data 2} {:data 3}) # -> @{:data 3}
