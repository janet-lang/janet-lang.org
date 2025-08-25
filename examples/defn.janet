(defn simple
  [x]
  (print (+ x 1)))

# prints 11
(simple 10) # -> nil

(defn long-body
  [y]
  (print y)
  (print (+ y 1))
  (print (+ y 2))
  (+ y 3))

(defn with-docstring
  "This function has a docstring"
  []
  (print "hello!"))

(defn with-tags
  :tag1 :tag2 :private
  "Also has a docstring and a variadic argument 'more'!"
  [x y z & more]
  [x y z more])

(with-tags 1 2) # compile error: <function with-tags> expects at least 3 arguments, got 2
(with-tags 1 2 3) # -> (1 2 3 ())
(with-tags 1 2 3 4) # -> (1 2 3 (4))
(with-tags 1 2 3 4 5) # -> (1 2 3 (4 5))

# Tags (and other metadata) are (usually) visible in the environment.
(dyn 'with-tags) # -> @{:tag2 true :value <function with-tags> :doc "(with-tags x y z & more)\n\nAlso has a docstring..." :source-map ("repl" 4 1) :tag1 true :private true}

