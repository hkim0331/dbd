(ns dbd.views.views
  (:require [compojure.core :refer :all]
            [dbd.models :as models]
            [dbd.views.layout :as layout]))

(defn index []
  (layout/common
   "index"
   [:table
    (for [e (models/all-entries)]
      [:tr
       [:td (:ip e)]
       [:td (:fqdn e)]
       [:td (:mac e)]
       [:td (:user e)]
       ])]))
