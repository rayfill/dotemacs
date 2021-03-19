(eval-when (compile load execute)
  (require 'use-package)
  (require 'nodejs-repl))


(defun quit-repl-window ()
  (interactive)
  (quit-window))

(use-package nodejs-repl
  :bind
  (:map nodejs-repl-mode-map
	("C-x o" . quit-repl-window)))

