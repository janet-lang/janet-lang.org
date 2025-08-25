# In a file module.janet
(defn- not-exposed-fn
  [x]
  (+ x x))
(not-exposed-fn 10) # -> 20

# In a file main.janet
(import module)

(module/not-exposed-fn 10) # -> compile error: unknown symbol module/not-exposed-fn

# Same as
(defn not-exposed-fn
  :private
  [x]
  (+ x x))
