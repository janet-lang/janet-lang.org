(def syms (all-bindings))

(defn check-one [patt sym]
  (= 0 (string/find patt sym)))

(defn check-pred [sym]
  (= (dec (length sym)) (string/find "?" sym)))

(defn findsome [patt]
  (filter (partial check-one patt) syms))

(def operators '(+ - * % / ++ -- += -= *= /= %= < > <= >= = 
                 == not= order< order> order>= order<= not inc dec and or))

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
(def io-funcs (array/concat @['stdout 'stderr 'stdin] (findsome "file")))
(def def-forms '(def- defn defn- defmacro defmacro- defglobal varglobal))
(def macro-helpers '(defmacro defmacro- idempotent? gensym with-syms macex macex1))
(def module-forms (findsome "module"))
(def flow-forms '(if-not when unless cond case let try if-let when-let match))
(def misc-forms '(comment default sort sorted doc *doc-width* doc* pp meta all-bindings keyword symbol getline apply resume yield error get put))
(def loop-forms '(loop seq for each while generate))

(defn listify [bindings]
  # Make sure all bindings are valid
  (string "<p>" 
          ;(map (fn [x] 
                  (string "<span><a href=\"doc.html#" 
                          x "\">"
                          x "</a></span> "))
                (sorted bindings order<)) "</p>"))
