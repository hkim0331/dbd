(ns dbd.views.layout
  (:require [hiccup.page :refer [html5 include-css]]))

(defn common [title & body]
  (html5
    [:head
     [:title title]
     (include-css "/css/bootstrap.min.css")
     (include-css "/css/screen.css")]
    [:body
     [:div.container (seq body)]]))
