#
# Markdown
#
# Use the peg module to convert markdown to HTML.
# Used to generate nice looking documentation for
# janet. The markdown might not be as full featured
# as other markdown flavors but should have all of the
# basic markdown functionality.

(import tools/highlight :as hl)
(import tools/html :as html)

(defn- get-header
  [prefix & content]
  (def n (length prefix))
  (string "<h" n ">" ;content "</h" n ">"))

(defn- get-anchor
  [& args]
  (string "<a href=\"" (last args) "\">" ;(tuple/slice args 0 -2) "</a>"))

(defn- get-image
  [& args]
  (string "<img src=\"" (last args) "\">" ;(tuple/slice args 0 -2) "</img>"))

(defn- line-el
  "Create a peg pattern for parsing some markup
  on a line. Captures the HTML text to output."
  [delim tag]
  (def open (string "<" tag ">"))
  (def close (string "</" tag ">"))
  ~(* ,delim
      (constant ,open)
      (any (if-not ,delim :token))
      (constant ,close)
      ,delim))

(defn trace [msg] (fn [&] (print msg) true))

(defn- trow
  "Build grammar for table row"
  [tag]
  (def open (string "<" tag ">"))
  (def close (string "</" tag ">"))
  ~(* (constant "<tr>")
      "|"
      (some (* (constant ,open)
               (any :table-token)
               (constant ,close)
               "|"
               :opt-ws))
      (constant "</tr>")
      :nl))

# Peg grammar for markdown -> html
(def- grammar
  ~{:next '(any (+ (set "\t \n\r") -1))
    :ws (some (set "\t "))
    :opt-ws (any (set "\t "))
    :nl-char (+ (* (? "\r") "\n") -1)
    :nl ':nl-char
    :opt-nl (? :nl-char)
    :escape (* "\\" '1)
    :anchor-text (* "[" (any (if-not "]" :token)) "]")
    :img-text    (* "![" (any (if-not "]" :token)) "]")
    :anchor-ref  (* "(" '(some (if-not ")" 1)) ")")
    :anchor (/ (* :anchor-text :anchor-ref) ,get-anchor)
    :img (/ (* :img-text :anchor-ref) ,get-image)
    :strong ,(line-el "**" "strong")
    :em     ,(line-el "*" "em")
    :table (* (constant "<table>")
              ,(trow "th")
              (* (any (if-not :nl-char 1)) :nl-char)
              (any ,(trow "td"))
              (constant "</table>"))
    :code    (* "`"
               (constant "<code class=\"code-inline\">")
               (/ '(any (if-not "`" 1)) ,html/escape)
               (constant "</code>")
               "`")
    :codeblock-inner '(any (if-not "```" 1))
    :codeblock (* "```"
                  (+ (* "janet" :opt-ws :opt-nl (/ :codeblock-inner ,hl/html))
                     (* :opt-ws :opt-nl
                        (constant "<pre class=\"codeblock\"><code>")
                        (/ :codeblock-inner ,html/escape)
                        (constant "</code></pre>")))
                  "```")
    :table-token (+ :img :anchor :strong
                    :em :code :escape '(if-not (set "\n|") 1))
    :token (* ':opt-ws (+ :img :anchor :strong
                          :em :code :escape '(if-not :nl-char 1)))
    :lines (some (* (some :token) :nl))
    :li (* (constant "<li>") (some :token) :nl (constant "</li>"))
    :ulli (* :opt-ws (set "-*") :li)
    :olli (* :opt-ws (some (range "09")) "." :li)
    :ul (* (constant "<ul>") (some :ulli) (constant "</ul>") :nl)
    :ol (* (constant "<ol>") (some :olli) (constant "</ol>") :nl)
    :paragraph (* (constant "<p>") (* :lines :nl-char) (constant "</p>"))
    :header (/ (* '(between 1 6 "#") (some :token) :nl) ,get-header)
    :directive (drop (/ (* "{%" '(any (if-not "%}" 1)) "%}") ,eval-string))
    :main (% (any (* :next
                     (+ :directive :header :ul :ol
                        :codeblock :table :paragraph -1 (error "")))))})

(def peg 
  "A peg that converts markdown to html."
  (peg/compile grammar))
