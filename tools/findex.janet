(def title "Function Index")
(def description "A Listing of all functions, macros, variables, and constants
in the Janet core library.")
(def prev-page {
 :link "/abstract_machine.html"
 :text "Abstract Machine"})
(def next-page {
 :link "/"
 :text "Home"})

(def syms (all-bindings))

(defn check-one [patt sym]
  (= 0 (string/find patt sym)))

(defn check-pred [sym]
  (= (dec (length sym)) (string/find "?" sym)))

(defn findsome [patt]
  (filter (partial check-one patt) syms))

(def operators '(+ - * % / ++ -- += -= *= /= %= < > <= >= = 
                 == not= order< order> order>= order<= not inc dec and or deep= deep-not=))

(def specs '(break var def while set if fn quote unquote quasiquote do splice))

(def asm-funcs '(asm disasm))
(def array-funcs (findsome "array"))
(def buffer-funcs (findsome "buffer"))
(def string-funcs (findsome "string"))
(def predicates (filter check-pred syms))
(def threading '(-> ->> -?> -?>> as-> as?->))
(def table-funcs (findsome "table"))
(def struct-funcs (findsome "struct"))
(def tuple-funcs (findsome "tuple"))
(def peg-funcs (findsome "peg"))
(def os-funcs (findsome "os"))
(def fiber-funcs (findsome "fiber"))
(def io-funcs (array/concat @['slurp 'spit 'stdout 'stderr 'stdin] (findsome "file")))
(def def-forms '(def- defn defn- defmacro defmacro- defglobal varglobal))
(def macro-helpers '(defmacro defmacro- idempotent? gensym with-syms macex macex1))
(def module-forms (array/concat @['load-image 'make-image 'import 'require 'import*] (findsome "module")))
(def flow-forms '(if-not when unless cond case let try if-let when-let match))
(def misc-forms '(comment default doc *doc-width* doc* pp meta all-bindings keyword symbol getline resume yield error get put make-env eval-string eval run-context bad-compile bad-parse repl))
(def combinators '(map reduce filter find keep pairs keys values merge update sum product identity complement extreme max min max-order min-order first last mapcat count find-index comp sort sorted range  take-until take-while drop-until drop-while juxt juxt* walk prewalk postwalk partial every? reverse invert zipcoll frequencies interleave distinct flatten flatten-into kvs interpose partition all some))
(def loop-forms '(loop seq for each while generate))

(defn listify [bindings]
  # Make sure all bindings are valid
  (string "<p>" 
          ;(map (fn [x] 
                  (string "<span><a href=\"doc.html#" 
                          x "\">"
                          x "</a></span> "))
                (sorted bindings order<)) "</p>"))
