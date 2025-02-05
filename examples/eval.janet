(eval '(+ 1 2 3)) # -> 6
(eval '(error :oops)) # -> error :oops
(eval '(+ nil nil)) # -> error: could not find method :+ for nil or :r+ for nil
