(defn worker
  "Do some work in another thread."
  [parent]
  (for i 0 10
    (os/sleep 0.1)
    (print "got message: " (thread/receive math/inf)))
  (:send parent "done!"))

(let [t (thread/new worker)]
  (for i 0 10
    (:send t (string "message no. " i))))

# Wait for done message
(print (thread/receive math/inf))
