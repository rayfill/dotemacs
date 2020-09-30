(unless (file-exists-p (expand-file-name "~/.emacs.d/elpa"))
  (format "%s" (expand-file-name "~/.emacs.d/elpa"))
  (package-refresh-contents nil))
(package-install 'exec-path-from-shell)
(package-install 'use-package)
(package-install 'go-mode)
(package-install 'lsp-mode)
(package-install 'lsp-ui)
(package-install 'company-lsp)
(package-install 'multi-web-mode)
(package-install 'typescript-mode)
(package-install 'which-key)
(package-install 'sql-indent)

