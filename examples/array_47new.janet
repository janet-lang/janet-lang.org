(def arr (array/new 100)) # -> @[]

# Now we can fill up the array without triggering a resize
(for i 0 100
  (put arr i i))
