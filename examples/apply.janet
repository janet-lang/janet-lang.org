(apply + (range 10)) # -> 45
(apply + []) # -> 0
(apply + 1 2 3 4 5 6 7 [8 9 10]) # -> 55
(apply + 1 2 3 4 5 6 7 8 9 10) # -> error: expected array|tuple, got number 

# Can also be used to call macros like functions.
# Will return the macro expanded code of the original macro.
(apply for 'x 0 10 ['(print x)])
# -> (do (var _000000 0) (def _000001 10) (while ...
