(ns dbd.handler
  (:require [compojure.core :refer [defroutes routes]]
            [ring.middleware.resource :refer [wrap-resource]]
            [ring.middleware.file-info :refer [wrap-file-info]]
            [hiccup.middleware :refer [wrap-base-url]]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [dbd.routes.app  :refer [app-routes]]
            [dbd.routes.home :refer [home-routes]]))

(defn init []
  (println "dbd is starting"))

(defn destroy []
  (println "dbd is shutting down"))

;; (def app
;;   (-> (routes app-routes)
;;       (handler/site)
;;       (wrap-base-url)))

(def app
  (-> app-routes
      (wrap-resource "public")
      ))
