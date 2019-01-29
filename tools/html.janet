# HTML escaping for text

(def- escapes
  {38 "&amp;"
   60 "&lt;"
   62 "&gt;"
   34 "&quot;"
   39 "&#39;"
   47 "&#47;"})

(defn escape
  "Escape special characters for HTML encoding."
  [str]
  (def buf @"")
  (loop [byte :in str]
    (if-let [rep (get escapes byte)]
      (buffer/push-string buf rep)
      (buffer/push-byte buf byte)))
  buf)
