;;;; icd9it-clim.lisp

(in-package icd9it-clim)

; to unzip run, adapting the paths
;(deoxybyte-gzip:gunzip "data.gz" "DatatreeClimIcd9it.lisp") 

(defparameter icd (with-open-file (i "~/Programming/Projects/IcdIt2007/Data/DatatreeClimIcd9it.lisp") (read i)))

(define-application-frame icd9it (cw:tree)
  ((info :accessor info :initform ""))
  (:command-table (icd9it :inherit-from (cw:tree)))
  (:panes 
   (tree :application :display-function 'cw:display-tree :incremental-redisplay t :end-of-line-action :allow :end-of-page-action :allow)
   (info :application :display-function 'disp-info :incremental-redisplay t))
	(:layouts (double (horizontally () tree (make-pane 'clim-extensions:box-adjuster-gadget) info))))

(defun disp-info (f p)
  (mapc (lambda (x)
          (flet ((wdo (s stg ink) (with-drawing-options (s :ink ink :text-face :bold) (princ stg s))))
            (cond ((string= x "Incl.:") (wdo p x +green+)) ((string= x "Escl.:") (wdo p x +red+)) ((#~m'Not[ae]:' x) (wdo p x +foreground-ink+)) (t (princ x p)))))
        (ppcre:split "(Not[ae]:|Escl.:|Incl.:)" (info *application-frame*) :with-registers-p t)))

(define-presentation-type icd () :inherit-from 'string)
(define-presentation-method present (item (type icd) s v &key) (princ (first (ppcre:split #\| item)) s))
(define-icd9it-command show-info ((item 'icd :gesture :select)) (setf (info *application-frame*) (second (ppcre:split #\| item))))

(defun icdview (tree key)
  (cw:t2h tree)
  (cw:tree-view (make-instance 'cw:node :sup key :disp-inf t) 'icd 'icd9it :right 800))

(defun icd-clim () (icdview icd "icd|"))
