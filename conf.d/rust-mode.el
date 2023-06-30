(cl-eval-when (:compile :load :execute)
  (require 'rust-mode))


(use-package rust-mode
  :mode "\\.rs\\'"
  )
