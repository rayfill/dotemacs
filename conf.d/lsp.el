(use-package lsp-mode
  :init
  (require 'bind-key)
  (require 'lsp-mode)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t)
     ("gopls.noIncrementalSync" t)
     ("gopls.watchFileChanges" t)))
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-log-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental) ;; always, send, incremental
  (lsp-prefer-flymake 'flymake)
  (lsp-enable-completion-at-point nil)
  :bind
  (:map lsp-mode-map
	("C-c C-p a" . lsp-workspace-folders-add)
	("C-c C-p o" . lsp-workspace-folders-open)
	("C-c C-p r" . lsp-workspace-folders-remove)
	("C-c C-p d" . lsp-workspace-folders-remove)
	("C-c r". lsp-rename)
	("C-`" . flymake-goto-next-error))
  :config
  (require 'lsp-clients)
  ;; LSP UI tools
  (use-package lsp-ui
    :init
    (require 'bind-key)
    :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top) ;; top, bottom, or at-point
    (lsp-ui-doc-max-width 150)
    (lsp-ui-doc-max-height 30)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit t)
    ;; lsp-ui-flycheck
    (lsp-ui-flycheck-enable nil)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable nil)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-sideline-show-diagnostics nil)
    (lsp-ui-sideline-show-code-actions nil)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-peek-height 20)
    (lsp-ui-peek-list-width 50)
    (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
    ;; lsp-ui-imenu
    (lsp-ui-imenu-enable t)
    (lsp-ui-imenu-kind-position 'top)
    :bind
    (:map lsp-mode-map
	  ("C-c C-r" . lsp-ui-peek-find-references)
	  ("C-c C-j" . lsp-ui-peek-find-definitions)
	  ("C-c i" . lsp-ui-peek-find-implementation)
	  ("M-." . xref-find-definitions)
	  ("C-c m" . lsp-ui-imenu)
	  ("C-c TAB" . lsp-ui-imenu)
	  ("C-c s" . lsp-ui-sideline-mode))
    :commands lsp-ui-mode
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (eval-after-load "flymake"
      (setq flymake-fringe-indicator-position nil)))
  (use-package company-lsp
    :custom
    (company-lsp-cache-candidates t) ;; always, using, cache
    (company-lsp-async t)
    (company-lsp-enable-recompletion nil))
  :commands lsp)
