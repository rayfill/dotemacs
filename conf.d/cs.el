(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'csharp-mode))

(use-package csharp-mode
  :mode "\\.cs\\'"
  )
