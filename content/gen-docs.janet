# Generate documentation

(import mendoza/markup-env :as mdz)
(import ./examples :as ex)

(defn- remove-extra-spaces
  "Many docstrings have extra spaces that don't look
  good when formatted. This removes them."
  [str]
  (var ret str)
  (for i 0 10
    (set ret (string/replace "  " " " ret)))
  ret)

(defn- check-example
  "Check if a binding has related examples. If so, load them
  and get their content."
  [sym]
  (def path (ex/sym-to-filename sym))
  (when (= :file (os/stat path :mode))
    (def src (slurp path))
    src))

(def- url-repl-chars
  {(chr "%") "%25"
   (chr "?") "_q"
   (chr "=") "%3d"
   (chr "/") "%2f"})

(defn jdoc-escape
  [str]
  (def ret @"")
  (when-let [prefix (dyn :jdoc-prefix)]
    (buffer/push ret prefix))
  (each b str
    (if-let [repl (in url-repl-chars b)]
      (buffer/push-string ret repl)
      (buffer/push-byte ret b)))
  ret)

(def- ver janet/build)

(def- installed-files-dir (string (os/cwd) "/build"))

(defn- clean-source-file
  [path]
  (if (string/has-prefix? "/" path)
    (string/slice path (length installed-files-dir))
    path))

(defn- get-pkg-version
  [pkg-name]
  (let [info (-> (string "build/.manifests/" pkg-name ".jdn") slurp parse)]
    (assert info)
    (assert (get info :tag))))

(def spork-version (get-pkg-version "spork"))
(def jpm-version (get-pkg-version "jpm"))

(defn github-source-linker
  "Get source code link for a given library (github)"
  [library commitish file line]
  (string "https://github.com/" library "/blob/" commitish "/" (clean-source-file file) "#L" line))

(defn janet-source-linker
  "Source code link for the functions in the janet interpreter"
  [file line]
  (string "https://github.com/janet-lang/janet/blob/" ver "/"
          (if (= "boot.janet" file) "src/boot/boot.janet" file) "#L" line))

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
                       (type val))
        docstring (remove-extra-spaces docstring)
        source-linker (dyn :source-linker janet-source-linker)
        example (check-example key)
        c-example (not (dyn :no-community-examples))]
    {:tag "div" "class" "binding"
     :content [{:tag "span" "class" "binding-sym" "id" key :content key} " "
               {:tag "span" "class" "binding-type" :content binding-type} " "
               ;(if sm [{:tag "span" "class" "binding-type"
                         :content {:tag "a"
                                   "href" (source-linker (sm 0) (sm 1))
                                   :content "source"}}] []) " "
               {:tag "pre" "class" "binding-text" :content (or docstring "")}
               ;(if example [{:tag "div" "class" "example-title" :content "EXAMPLES"}
                             {:tag "pre" "class" "mendoza-codeblock"
                              :content {:tag "code" :language (require "janet.syntax") :content (string example)}}] [])
               (if c-example
                 {:tag "a" "href"
                  (string "https://janetdocs.org/core-api/" (jdoc-escape key)) # Spork will be "https://janetdocs.org/spork/", JPM .org/jpm/ etc.
                  :content "Community Examples"})]}))

(defn- all-entries 
  [&opt env]
  (default env root-env)
  (sort (pairs env)))

(defn- get-from-prefix
  "Get all bindings that start with a prefix."
  [prefix &opt env]
  (seq [x :in (all-entries env)
        :let [[k entry] x]
        :when (symbol? k)
        :when (get entry :doc)
        :when (not (get entry :private))
        :when (string/has-prefix? prefix k)]
       x))

(defn- get-from-peg
  "Get all bindings that start with a prefix."
  [peg &opt env]
  (seq [x :in (all-entries env)
        :let [[k entry] x]
        :when (symbol? k)
        :when (get entry :doc)
        :when (not (get entry :private))
        :when (peg/match peg (string k))]
       x))

(defn gen-peg
  "Generate the document for all of the core api whose name matches the peg."
  [peg &opt env]
  (def entries (get-from-peg peg env))
  (def index
    (seq [[k entry] :in entries]
         [{:tag "a" "href" (string "#" k) :content k} " "]))
  (def bindings
    (seq [[k entry] :in entries]
         [{:tag "hr" :no-close true} (emit-item k entry)]))
  [{:tag "p" :content index} bindings])

(defn gen-prefix
  "Generate the documentation for some subset of the core api."
  [prefix &opt env]
  (gen-peg (peg/compile prefix) env))

(defn gen-prefix-current
  "Generate the documentation for some module in that has been loaded"
  [prefix]
  (gen-peg (peg/compile prefix) (curenv)))

(defn gen
  "Generate all bindings."
  []
  (gen-prefix ""))
