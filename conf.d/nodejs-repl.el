(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'nodejs-repl))


(defun quit-repl-window ()
  (interactive)
  (quit-window))

(use-package nodejs-repl
  :bind
  (:map nodejs-repl-mode-map
	("C-x o" . quit-repl-window)))

