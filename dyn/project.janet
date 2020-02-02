(declare-project
  :name "janet-lang.org"
  :dependencies ["circlet" "sqlite3" "json"])

(declare-executable
  :name "jlorg"
  :entry "main.janet")
