(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'cc-mode))

(use-package cc-mode
  :config
  (setq indent-tabs-mode nil)
  :mode "\\.[ch]\\(pp\\|++\\|xx\\)\\'")
