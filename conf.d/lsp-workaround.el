(cl-eval-when (:compile-toplevel :load :execute)
  (require 's))

(defun json-parse-string-advicer (orig string &rest rest)
  (print (format "json-parse-string %s %s" string rest))
  (apply orig (s-replace "\u0000" "" string)
         rest))
(advice-add 'json-parse-string :around
            #'json-parse-string-advicer)
;(advice-remove 'json-parse-string #'json-parse-string-advicer)

;(json-read-from-string string)
(defun json-read-from-string-advicer (orig string &rest)
  (format "json-read-from-string %s %s" string rest)
  (apply orig (s-replace "\u0000" "" string) rest))
(advice-add 'json-read-from-string :around
            #'json-read-from-string-advicer)
;; (advice-mapc (lambda (&rest args)
;;                (print (format "advice: %s" args)))
;;              'json-read-from-string)
;(advice-remove 'json-read-from-string #'json-read-from-string-advicer)

(defun json-parse-buffer-advicer (orig &rest rest)
  (save-excursion
    (relace-string "\u0000" "")
    (apply orig rest)))

(advice-add 'json-parse-buffer :around
            #'json-parse-buffer-advicer)
;(advice-remove 'json-parse-buffer #'json-parse-buffer-advicer)
