(setq inferior-js-program-command "nodejs")
(push '("\\.js\\'" . js2-mode) auto-mode-alist)

(defun js2-comint-hook ()
  (local-set-key (kbd "C-x C-e") 'js-send-last-sexp)
  (local-set-key (kbd "C-c C-e") 'js-send-last-sexp-and-go)
  (local-set-key (kbd "C-c C-b") 'js-send-buffer-and-go))


(add-hook 'js2-mode-hook #'js2-comint-hook)


