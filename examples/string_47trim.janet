# trim leading and trailing whitespace
(string/trim "  foo ") # -> "foo"

# default whitespace includes " \t\r\n\v\f"
(string/trim "\t bar\n\r\f") # -> "bar"

# provide custom set of characters to trim
(string/trim "_.foo_bar. \n" " ._\n") # -> "foo_bar"