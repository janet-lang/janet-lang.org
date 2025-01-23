(defn setup []
  (printf "  -> running setup code, first time only."))

(def setup-once
  (delay
   (setup)
   "setup complete"))

repl:127:> (setup-once)
  -> running setup code, first time only.
"setup complete"
repl:128:> (setup-once)
"setup complete"