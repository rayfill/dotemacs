(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'treemacs)
  (require 'lsp-treemacs))


(use-package treemacs
  :custom
  (treemacs-persist-file "/dev/null"))

(use-package lsp-treemacs
  :init
  (lsp-treemacs-sync-mode 1))
