#!/usr/bin/env janet

# Implements a templating tool for the static part of the website.
# Uses handlebars like syntax for website layout.

(import highlight :as hl)
(import tools/md :as md)

#
# Get options
#

(def opts (table ;(tuple/slice process/args 2)))
(loop [[k v] :pairs opts
       :when (zero? (string/find "--" k))]
  (defglobal (symbol (string/slice k 2)) v))

(defn markdown
  "Convert markdown to HTML."
  [markup]
  (0 (peg/match md/peg markup)))

#
# HTML escape
#

(def html-escape hl/html-escape)

#
# Template parser
#

(def template-grammar
  ~{:code (/ (* "{%" '(any (if-not "%}" 1)) "%}") ,eval-string)
    :main (% (any (+ :code '1)))})

(def template-peg (peg/compile template-grammar))

# Exectute tool with command line options
(defn write-out
  [str]
  (def oopt (opts "--out"))
  (if oopt
    (spit oopt str)
    (print str)))
(def topt (opts "--template"))
(def template (if topt (slurp topt) (file/read stdin :all)))
(as-> template x
  (0 (peg/match template-peg x))
  (write-out x))
