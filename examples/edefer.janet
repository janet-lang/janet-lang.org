# Half of the time, return "ok", the other
# half of the time, print there was an error and throw "oops".
(edefer (print "there was an error")
  (if (< (math/random) 0.5)
    (error "oops")
    "ok"))
