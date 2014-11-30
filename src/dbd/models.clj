(ns dbd.models
  (:refer-clojure)
  (:use korma.db korma.core)
  (:require [clojure.string :as string])
  )

(defdb db
  (sqlite3 {:db "resources/db/dbd.sqlite3"}))

(defentity tbl
  (entity-fields :id :fqdn :ip :mac :rev :user :updated_at :created_at))

(defn all-entries []
  (select tbl))

(defn create-entry [entry]
  (insert tbl (values entry)))

(defn entry-by-id [id]
  (first (select tbl (where {:id id}))))

