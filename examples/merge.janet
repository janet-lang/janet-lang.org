(merge {:a 1} {:b 2}) # -> @{:a 1 :b 2}
(merge @{:x 10} @{:y 20} @{:x 20}) # -> @{:x 20 :y 20}
(merge {:fish 1} @{:oak 2} {:enoki 3}) # -> @{:enoki 3 :fish 1 :oak 2}
