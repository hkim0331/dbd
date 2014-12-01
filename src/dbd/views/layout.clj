(ns dbd.views.layout
  (:require [hiccup.page :refer [html5 include-css]]))

(defn common [title & body]
  (html5
    [:head
     [:title title]
     (include-css "/css/bootstrap.min.css")
     (include-css "/css/screen.css")]
    [:body
     [:div {:class "navbar navbar-inverse"}
      [:div {:class :navbar-inner}
       [:a {:class :brand :href "/"} "dhcp-bind database"]
       [:form {:class "navbar-form pull-right"}
        [:input {:type :text :class :search-query :placeholder :Search}]]]]
     [:div.container (seq body)]
     [:hr]
     "programmed by hiroshi.kimura.0331@gmail.com"
     ]))
