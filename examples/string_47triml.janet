# trim leading/left side whitespace
(string/triml "  foo ") # -> "foo "

# default whitespace includes " \t\r\n\v\f"
(string/triml "\t bar\n\r\f") # -> "bar\n\r\f"

# provide custom set of characters to triml
(string/triml "_.foo_bar. \n" " ._\n") # -> "foo_bar. \n"