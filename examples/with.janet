# Print all of poetry.txt, and close the file when done,
# even when there is an error.
(with [f (file/open "poetry.txt")]
  (print (:read f :all)))
