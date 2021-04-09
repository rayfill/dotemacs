(cl-eval-when (:compile :load :execute)
  (require 'use-package)
  (require 'lsp-mode)
  (require 'company)
  (require 'flymake))

(setenv "TSSERVER_LOG_FILE" "/tmp/tsserver.log")

(use-package lsp
  :hook (typescript-mode js-mode go-mode))

(use-package lsp-mode
  :init
  (require 'bind-key)
  (require 'lsp-mode)
  :custom
  (gc-cons-threshold (* 128 1024 1024))
  (read-process-output-max (* 1024 1024))
  ;; debug
  (lsp-print-io nil)
  (lsp-log-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  (lsp-eslint-enable nil)
  ;; general
  (lsp-auto-guess-root nil)
  (lsp-document-sync-method lsp--sync-incremental) ;; lsp--sync-none, lsp--sync-full or lsp--sync-incremental
  (lsp-diagnostics-provider :flymake)
  (lsp-enable-completion-at-point t)
  :bind
  (:map lsp-mode-map
	("C-c C-p a" . lsp-workspace-folders-add)
	("C-c C-p o" . lsp-workspace-folders-open)
	("C-c C-p r" . lsp-workspace-folders-remove)
	("C-c C-p d" . lsp-workspace-folders-remove)
	("C-c r". lsp-rename)
	("C-." . company-complete)
	("C-`" . flymake-goto-next-error))
  :commands lsp)

;; LSP UI tools
(use-package lsp-ui
  :init
  (require 'bind-key)
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
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
  :hook typescript-mode js-mode
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
  :hook lsp-mode)
