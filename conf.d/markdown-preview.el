(eval-when-compile
  (require 'use-package)
  (require 'markdown-preview-mode))

(when (executable-find "markdown")
  (use-package markdown-preview-mode
    :config
    (setq markdown-preview-stylesheets (list "https://cdn.jsdelivr.net/npm/github-markdown-css@3.0.1/github-markdown.min.css"))))
