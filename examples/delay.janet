(def setup-once
  (let [setup |(print "running setup")]
    (delay
     (setup)
     "setup complete")))

# first run will print "running setup" followed by "setup complete"
(printf "first run: %s" (setup-once))

# after that, only prints cached value "setup complete"
(printf "second run: %s" (setup-once))