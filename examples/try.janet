# when no error, return result of `body`
(try
  (do
    :not-much
    true)
  ([_]
    :not-reached))
# -> true

# when an error, return result of `catch`
(try
  (error :a-value)
  ([e]
    (type e)))
# -> :keyword

# fiber wrapping `body` can be available on error
(try
  (error "fun")
  ([_ fib]
    (type fib)))
# -> :fiber

