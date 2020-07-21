(use-package typescript-mode
  :config
  (setq auto-mode-alist
	(cons (cons "\\.ts$" 'typescript-mode) auto-mode-alist)))
