(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (straight-use-package '(tsi :type git :host github :repo "orzechowskid/tsi.el"))
  (straight-use-package '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el")))


(use-package tsx-mode
  :config
  :mode "\\.tsx\\'"
  :bind
  (:map tsx-mode-map
        ))
