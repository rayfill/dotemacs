(use-package multi-web-mode
  :config
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags 
	'((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
	  (js-mode  "<script[^>]*>" "</script>")
	  (css-mode "<style[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
  (setq auto-mode-alist
	(cons (cons "\\.html?$" 'js-mode) auto-mode-alist))
  (multi-web-global-mode 1))
