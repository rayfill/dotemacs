(cl-eval-when (:compile :load :execute)
  (require 'cc-mode)
  (require 'cc-vars))

(use-package exec-path-from-shell
  :config
  (let ((envs '("PATH" "GOROOT" "GOPATH"))
	(go-path (getenv "GOPATH")))
    (exec-path-from-shell-copy-envs envs)
    (when go-path
      (push go-path exec-path))))

(use-package go-mode
  :commands go-mode
  :defer t
  :bind
  (:map go-mode-map
   ("C-c d" . godoc)
   ("C-x SPC" . gud-break))
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook #'lsp)
  :custom
  (indent-tabs-mode nil)
  (c-basic-offset 4)
  (tab-width 4))
