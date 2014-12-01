(ns dbd.views.views
  (:require [compojure.core :refer :all]
            [dbd.models :as models]
            [dbd.views.layout :as layout]
            [hiccup.form :refer [form-to text-field submit-button]]))

(defn index []
  (layout/common
   "index"
   [:div.row.admin-bar
    [:a {:href "/entries/new"}
     "Add Entry"]]
   [:h1 "dhcp-bind database"]
   [:table
    [:tr
     [:th {:class "ip"} "IP"]
     [:th {:class "fqdn"} "FQDN"]
     [:th {:class "mac"} "MAC"]
     [:th {:class "user"} "OWNER"]
     ]
    (for [e (models/all-entries)]
      [:tr
       [:td {:class "data"} (:ip e)]
       [:td {:class "data"} (:fqdn e)]
       [:td {:class "data"} (:mac e)]
       [:td {:class "data"} (:user e)]
       ])]))

(defn new-entry []
  (layout/common
   "new entry"
   [:h1 "Create an Entry"]
   (form-to
    [:post "/entries"]

    (submit-button {:class "btn btn-primary"} "Create Entry"))))

(defn make-entry [& params]
  (layout/common
   "make entry"
   [:h1 "Make an Entry"]
   [:p "make-entry called,"])
  )

