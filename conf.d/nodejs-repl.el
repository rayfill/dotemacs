;; (defun nodejs-repl-execute-buffer-clean ()
;;   (interactive)
;;   (with-current-buffer (process-buffer (nodejs-repl--get-or-create-process))
;;     (delete-region (point-min) (point-max))))

;(add-hook 'js-mode-hook
;	  (lambda ()
;	    (setq indent-tabs-mode nil)
;	    (local-set-key (kbd "C-x C-e") 'nodejs-repl-send-region)
;	    (local-set-key (kbd "C-c C-c") 'nodejs-repl-send-buffer)
;	    (local-set-key (kbd "C-c M-o") 'nodejs-repl-execute-buffer-clean)
;	    (local-set-key (kbd "C-c TAB") 'nodejs-repl-switch-to-repl)))

(ignore-errors
  (require 'js-comint)
  (require 'js2-mode)

  (add-hook 'js2-mode-hook (lambda ()
			     (local-set-key (kbd "C-c C-b") 'js-send-buffer-and-go))))
