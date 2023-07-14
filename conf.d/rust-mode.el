(cl-eval-when (:compile :load :execute)
  (require 'rust-mode)
  (require 'cargo)
  )


(use-package rust-mode
  :mode "\\.rs\\'"
  :custom rust-format-on-save t
  )

(use-package cargo
  :hook (rust-mode . cargo-minor-mode)
  :bind
  )
