(ns dbd.routes.home
  (:require [compojure.core :refer :all]
            [dbd.views.layout :as layout]))

(defn home []
  (layout/common "Hello World!"
                 [:h1 "Hello World!"]
                 [:p "nice to meet you."]))

(defroutes home-routes
  (GET "/" [] (home)))
