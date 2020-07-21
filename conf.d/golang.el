(use-package exec-path-from-shell
  :config
  (let ((envs '("PATH" "GOROOT" "GOPATH")))
    (exec-path-from-shell-copy-envs envs))
  (push (getenv "GOPATH") exec-path))

(defun gmh ()
  (local-set-key (kbd "C-x SPC") 'gud-break)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (setq tab-width 4))

(use-package go-mode
  :commands go-mode
  :defer t
  :init
  (add-hook 'go-mode-hook #'gmh)
  :bind
  (:map go-mode-map
   ("C-c d" . godoc))
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook #'lsp))
