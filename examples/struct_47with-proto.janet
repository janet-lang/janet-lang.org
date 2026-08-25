(def st (struct/with-proto {:b 2} :a 1))
(struct/getproto st) # -> {:b 2}
(get st :a) # -> 1

# kvs are optional
(def st (struct/with-proto {:b 2}))
(struct/getproto st) # -> {:b 2}
(length st) # -> 0
