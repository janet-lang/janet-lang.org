(var ncmd 0)

(defn my-prompt
  `Takes a single argument p, the parser, and returns a prompt string.`
  [p]
  (++ ncmd)
  (string/format "[%d]> " ncmd))

(setdyn :repl-prompt my-prompt)
