(import sqlite3 :as sql)
(import circlet)
(import json)

### Server Functionality:
# Serve examples - keyed by form name
# Add examples - keyed by form name - authed user
# Remove examples - keyed by form name, user - authed user

(var *db* nil)

(def users-sql
  ```
  CREATE TABLE IF NOT EXISTS users(
  id INTEGER PRIMARY KEY,
  email TEXT);
  ```)

(def examples-sql
  ```
  CREATE TABLE IF NOT EXISTS examples(
  id INTEGER PRIMARY KEY,
  userId INTEGER,
  binding TEXT,
  body TEXT,
  timestamp INTEGER
  ```)

(def headers
  {"Content-Type" "application/json"})

(defn handler
  "Handle a request to the server"
  [req]
  (pp req)
  {:status 200 :headers headers :body (json/encode req)})

(defn main
  [& args]
  (set *db* (sql/open "comments.db"))
  (sql/eval *db* users-sql)
  (sql/eval *db* examples-sql)
  (circlet/server
    (-> handler circlet/router circlet/logger)
    8000))
