
(add-to-list 'load-path "/home/alfeim/jshint-mode")
(ignore-errors
  (require 'flymake-jshint)
  (add-hook 'javascript-mode-hook
	    (lambda () (flymake-mode t)))

  (custom-set-variables '(jshint-mode-node-program "nodejs")))
