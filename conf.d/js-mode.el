(use-package js
  :config
  (setq js-indent-level 2)
  (setq indent-tabs-mode nil)
  (setq auto-mode-alist
	(cons (cons "\\.js$" 'js-mode) auto-mode-alist))
  (add-hook 'js-mode-hook #'lsp))

