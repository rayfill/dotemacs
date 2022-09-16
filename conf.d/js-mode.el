(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'js2-mode)
  (require 'nodejs-repl))

(use-package js2-mode
  :config
  (setq js-indent-level 2)
  (setq indent-tabs-mode nil)
  :mode "\\.jsx?\\'"
  :bind
  (:map js-mode-map
        ("C-x C-e" . nodejs-repl-send-last-expression)
        ("C-c C-j" . nodejs-repl-send-line)
        ("C-c C-r" . nodejs-repl-send-region)
        ("C-c C-c" . nodejs-repl-send-buffer)
        ("C-c C-l" . nodejs-repl-load-file)
        ("C-c C-z" . nodejs-repl-switch-to-repl)))

