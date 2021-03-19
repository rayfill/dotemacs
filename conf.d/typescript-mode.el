(eval-when (compile load execute)
  (require 'use-package)
  (require 'flymake)
  (require 'typescript-mode))

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
(use-package typescript-mode
  :config
  (setq typescript-indent-level 2)
  (setq indent-tabs-mode nil)
  :mode "\\.ts\\'"
  :bind
  (:map typescript-mode-map
        ("C-x C-e" . nodejs-repl-send-last-expression)
        ("C-c C-j" . nodejs-repl-send-line)
        ("C-c C-r" . nodejs-repl-send-region)
        ("C-c C-c" . nodejs-repl-send-buffer)
        ("C-c C-l" . nodejs-repl-load-file)
        ("C-c C-z" . nodejs-repl-switch-to-repl)))
