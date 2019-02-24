# Copyright (C) Calvin Rose 2019
#
# Takes in a janet string and colorizes for multiple
# output formats.

(import tools/html :as html)

(def- html-colors
  {:number "j-number"
   :keyword "j-keyword"
   :string "j-string"
   :coresym "j-coresym"
   :constant "j-constant"
   :comment "j-comment"
   :line "j-line"})

(def html-style
  "Style tag to add to a page to highlight janet code"
```
<style type="text/css">
.j-main { color: white; background: #111; font-size: 1.4em; }
.j-number { color: #89dc76; }
.j-keyword { color: #ffd866; }
.j-string { color: #ab90f2; }
.j-coresym { color: #ff6188; }
.j-constant { color: #fc9867; }
.j-comment { color: darkgray; }
.j-line { color: gray; }
</style>
```)

(defn- paint
  "Paint colors for HTML"
  [what str]
  (def color (get html-colors what))
  (def escaped (html/escape str))
  (if color
    (string "<span class=\"" color "\">" escaped "</span>")
    escaped))

# Constants for checking if symbols should be
# highlighted.
(def- core-env (table/getproto *env*))
(def- specials {'fn true
               'var true
               'do true
               'while true
               'def true
               'splice true
               'set true
               'unquote true
               'quasiquote true
               'quote true
               'if true})

(defn check-number [text] (and (scan-number text) text))

(defn <-c
  "Peg rule for capturing and coloring a rule."
  [color what]
  ~(/ (<- ,what) ,(partial paint color)))

(defn color-symbol
  "Color a symbol only if it is a core library binding or special."
  [text]
  (def sym (symbol text))
  (def should-color (or (specials sym) (core-env sym)))
  (paint (if should-color :coresym :symbol) text))

(def grammar
  ~{:ws (set " \v\t\r\f\n\0")
    :readermac (set "';~,")
    :symchars (+ (range "09" "AZ" "az" "\x80\xFF") (set "!$%&*+-./:<?=>@^_|"))
    :token (some :symchars)
    :hex (range "09" "af" "AF")
    :escape (* "\\" (+ (set "ntrvzf0e\"\\")
                       (* "x" :hex :hex)
                       (error (constant "bad hex escape"))))

    :comment ,(<-c :comment ~(* "#" (any (if-not (+ "\n" -1) 1))))

    :symbol (/ ':token ,color-symbol)
    :keyword ,(<-c :keyword ~(* ":" (any :symchars)))
    :constant ,(<-c :constant ~(+ "true" "false" "nil"))
    :bytes (* "\"" (any (+ :escape (if-not "\"" 1))) "\"")
    :string ,(<-c :string :bytes)
    :buffer ,(<-c :string ~(* "@" :bytes))
    :long-bytes {:delim (some "`")
                 :open (capture :delim :n)
                 :close (cmt (* (not (> -1 "`")) (-> :n) ':delim) ,=)
                 :main (drop (* :open (any (if-not :close 1)) :close))}
    :long-string ,(<-c :string :long-bytes)
    :long-buffer ,(<-c :string ~(* "@" :long-bytes))
    :number (/ (cmt ':token ,check-number) ,(partial paint :number))

    :raw-value (+ :comment :constant :number :keyword
                  :string :buffer :long-string :long-buffer
                  :parray :barray :ptuple :btuple :struct :dict :symbol)

    :value (* (? '(some (+ :ws :readermac))) :raw-value '(any :ws))
    :root (any :value)
    :root2 (any (* :value :value))
    :ptuple (* '"(" :root (+ '")" (error "")))
    :btuple (* '"[" :root (+ '"]" (error "")))
    :struct (* '"{" :root2 (+ '"}" (error "")))
    :parray (* '"@" :ptuple)
    :barray (* '"@" :btuple)
    :dict (* '"@"  :struct)

    :main (+ (% (*
                  (constant "<pre class=\"j-main\"><code>")
                  :root
                  (constant "</code></pre>"))) (error ""))})

# Terminal syntax highlighting

(def- peg (peg/compile grammar))

# API

(defn html
  "Highlight janet source code and output HTML."
  [source]
  (0 (peg/match peg source)))
