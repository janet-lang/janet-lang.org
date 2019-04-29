# Generate documentation

(import mendoza/markup-env :as mdz)

(defn- emit-item
  "Generate documentation for one entry."
  [key env-entry]
  (let [{:macro macro
         :value val
         :ref ref
         :source-map sm
         :doc docstring} env-entry
        binding-type (cond
                       macro :macro
                       ref (string :var " (" (type (get ref 0)) ")")
                       (type val))]
    {:tag "div" "class" "binding"
     :content [{:tag "span" "class" "binding-sym" "id" key :content key} " "
               {:tag "span" "class" "binding-type" :content binding-type} " "
               {:tag "pre" "class" "binding-text" :content (or docstring "")}]}))

(def- all-entries 
  (sort (pairs (table/getproto (fiber/getenv (fiber/current))))))

(defn- get-from-prefix
  "Get all bindings that start with a prefix."
  [prefix]
  (def peg (peg/compile prefix))
  (seq [[k entry]
        :in all-entries
        :when (get entry :doc)
        :when (not (get entry :private))
        :when (peg/match peg k)]
       [k entry]))

(defn gen-prefix
  "Generate the document for all of the core api."
  [prefix]
  (def entries (get-from-prefix prefix))
  (def index
    (seq [[k entry] :in entries]
         [{:tag "a" "href" (string "#" k) :content k} " "]))
  (def bindings
    (seq [[k entry] :in entries]
         [{:tag "hr" :no-close true} (emit-item k entry)]))
  [index bindings])

(defn gen
  "Generate all bindings."
  []
  (gen-prefix ""))
