(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'terraform-mode)
  (require 'terraform-doc))

(use-package terraform-mode
  :mode "\\.tf\\'"
  )
