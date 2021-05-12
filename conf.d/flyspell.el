(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'flyspell))

(use-package flyspell
  :custom
  (ispell-program-name "aspell")
  )
