(use mendoza/template-env)

(defn render-toc
  "Render the table of contents for a page."
  [node]
  (def url (if (node :pages) (string (node :url) "/index.html") (node :url)))
  {:tag "li"
   "class" (if (node :pages) "caret")
   :content [{:tag "span" 
              "class" (if (= (dyn :url) url) "selected")
              :content {:tag "a" "href" (relative-url url) :content (or (node :nav-title) (node :title))}}
             (if-let [pages (node :pages)]
               {:tag "ul"
                :content (map render-toc pages)})]})

(var total-order nil)

(defn visit
  [node]
  (if-let [ps (node :pages)]
    (do 
      (if (node :index) (array/push total-order (node :index)))
      (each page ps (visit page)))
    (array/push total-order node)))

(defn get-total-order
  "Lazily get total order. This must be lazy because the sitemap is not
  built until after all templates have been parsed."
  []
  (unless total-order
    (set total-order @[])
    (visit (dyn :sitemap)))
  total-order)

(defn findrel
  "Find page offset from url in the total order"
  [url offset]
  (def order (get-total-order))
  (def len (length order))
  (def my-index (find-index (fn [x] (= url (x :url))) order))
  (def index (% (+ my-index len offset) len))
  (order index))

(defn find-old-versions
  "Get old versions of this documentation for link purposes."
  []
  (sort (seq [d :in (os/dir "static")
              :let [m (peg/match ~'(* (/ ':d+ ,scan-number) "." (/ ':d+ ,scan-number) "." (/ ':d+ ,scan-number)) d)]
              :when m
              :when (not= d janet/version)]
          (tuple ;m)) >))

(def other-versions (map last (find-old-versions)))
