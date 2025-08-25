# prints 0123456789 (not followed by newline)
(loop [x :range [0 10]]
  (prin x)) # -> nil

# Cartesian product (nested loops)

# prints 00010203101112132021222330313233
# Same as (for x 0 4 (for y 0 4 (prin x y)))
(loop [x :range [0 4]
       y :range [0 4]]
  (prin x y)) # -> nil

# prints bytes of "hello, world" as numbers
(loop [character :in "hello, world"]
  (print character)) # -> nil

# prints 1, 2, and 3, in an unspecified order
(loop [value :in {:a 1 :b 2 :c 3}]
  (print value)) # -> nil

# prints 0 to 99 inclusive
(loop [x :in (range 100)]
  (print x)) # -> nil

# Complex body
(loop [x :in (range 10)]
  (print x)
  (print (inc x))
  (print (+ x 2))) # -> nil
# prints n, n+1, n+2 (for n = 0 through 9) each time through the loop
# 0
# 1
# 2
# ...
# 9
# 10
# 11

# Iterate over keys
(loop [k :keys {:a 1 :b 2 :c 3}]
  (print k)) # -> nil
# print a, b, and c in an unspecified order

(loop [index :keys [:a :b :c :d]]
  (print index)) # -> nil
# print 0, 1, 2, and 3 in order.

(defn print-pairs
  [x]
  (loop [[k v] :pairs x]
    (printf "[%v]=%v" k v)))

(print-pairs [:a :b :c]) # -> nil
# prints
# [0]=:a
# [1]=:b
# [2]=:c

(print-pairs {:a 1 :b 2 :c 3}) # -> nil
# prints
# [:a]=1
# [:b]=2
# [:c]=3

# Some modifiers - allow early termination and conditional execution
# of the loop

(loop [x :range [0 100] :when (even? x)]
  (print x)) # -> nil
# prints even numbers 0, 2, 4, ..., 98

(loop [x :range [1 100] :while (pos? (% x 7))]
  (print x)) # -> nil
# prints 1, 2, 3, 4, 5, 6

# Consume fibers as generators
(def f
  (fiber/new
    (fn []
      (for i 0 100
        (yield i)))))

(loop [x :in f]
  (print x)) # -> nil
# print 0, 1, 2, ... 99

# Modifiers in nested loops
(loop [x :range [0 10]
      :after (print)
       y :range [0 x]]
  (prin y " ")) # -> nil
# prints
# 0
# 0 1
# 0 1 2
# 0 1 2 3
# 0 1 2 3 4
# 0 1 2 3 4 5
# 0 1 2 3 4 5 6
# 0 1 2 3 4 5 6 7
# 0 1 2 3 4 5 6 7 8

