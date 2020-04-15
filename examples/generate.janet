# An infinite stream of random numbers, but doubled.
(def g (generate [_ :iterate true :repeat 2] (math/random)))
# -> <fiber 0x5562863141E0>

(resume g) # -> 0.487181
(resume g) # -> 0.487181
(resume g) # -> 0.507917
(resume g) # -> 0.507917
# ...
