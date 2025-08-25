# a function that doubles its arguments
((fn [n] (+ n n)) 10) # -> 20
((short-fn (+ $ $)) 10) # -> 20

# pipe reader macro offers terser expression
(|(+ $ $) 10) # -> 20

# $0 is also the first (zero-th) argument
(|(+ $0 $0) 10) # -> 20

# handling multiple arguments: $0, $1, ...
(|(string $0 $1) "hi" "ho") # -> "hiho"

# variadic function
(|(apply + $&) 1 2 3) # -> 6

# structs and some other things work too
(|{:a 1}) # -> {:a 1}

