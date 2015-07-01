;;;; icd9it-clim.asd

(asdf:defsystem #:icd9it-clim
  :description "treeview italian icd codes with comments"
  :author "Schatzer Johann <j.schatzer@tin.it>"
  :license "code is free, not shure about data"
  :depends-on (clim-widgets deoxybyte-gzip)
  :serial t
  :components ((:file "package")
               (:file "icd9it-clim")))

