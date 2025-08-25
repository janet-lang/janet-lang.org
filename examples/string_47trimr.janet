# trim trailing/right side whitespace
(string/trimr "  foo ") # -> "  foo"

# default whitespace includes " \t\r\n\v\f"
(string/trimr "\t bar\n\r\f") # -> "\t bar"

# provide custom set of characters to trimr
(string/trimr "_.foo_bar. \n" " ._\n") # -> "_.foo_bar"