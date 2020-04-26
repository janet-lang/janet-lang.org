(eval-string "(+ 1 2 3 4)") # -> 10
(eval-string ")") # -> parse error
(eval-string "(bloop)") # -> compile error
(eval-string "(+ nil nil)") # -> runtime error
