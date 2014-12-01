(ns dbd.routes.app
  (:require [compojure.core :refer :all]
            [dbd.views.views :as views]))

(defroutes app-routes
  (GET "/" [] (views/index))
  (GET "/entries/new" [] (views/new-entry))
  (POST "/entries" [& params] (views/make-entry params))
  )

