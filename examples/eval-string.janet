(eval-string "(+ 1 2 3 4)") # -> 10
(eval-string ")") # -> error: unexpected closing delimiter )
(eval-string "(bloop)") # -> error: unknown symbol bloop
(eval-string "(+ nil nil)") # -> error: could not find method :+ for nil or :r+ for nil
