(eval '(+ 1 2 3)) # -> 6
(eval '(error :oops)) # -> raises error :oops
(eval '(+ nil nil)) # -> raises error
