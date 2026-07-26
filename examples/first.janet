(first "ABC") # -> 65
(first [:ant :bee]) # -> :ant

(def fib (coro (yield :a)))
(first fib) # -> nil
(resume fib)
(first fib) # -> :a

(first {:a 1}) # -> nil
(first math/pi) # -> nil
(first true) # -> nil
(first nil) # -> nil
