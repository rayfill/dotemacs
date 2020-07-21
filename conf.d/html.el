(use-package sgml-mode
  :config
  (setq auto-mode-alist
	(cons (cons "\\.html?$" 'html-mode) auto-mode-alist))
  (add-hook 'html-mode-hook #'lsp))
