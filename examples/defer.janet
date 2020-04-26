# Evaluates to 6 after printing "scope left!"
(defer (print "scope left!")
  (+ 1 2 3))

# cleanup will always be called, even if there is a failure
(defer (cleanup)
  (step-1)
  (step-2)
  (if (< 0.1 (math/random)) (error "failure"))
  (step-3))
