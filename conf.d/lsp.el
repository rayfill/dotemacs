(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'lsp-mode)
  (require 'lsp-treemacs)
  (require 'lsp-ui)
  (require 'company)
  (require 'flymake))

(setenv "TSSERVER_LOG_FILE" "/tmp/tsserver.log")

(defvar lsp-ui-doc-show/hide-toggle)
(defun lsp-ui-doc-show/hide ()
  (interactive)
  (unless (assoc 'lsp-ui-doc-show/hide-toggle (buffer-local-variables))
    (make-local-variable 'lsp-ui-doc-show/hide-toggle)
    (setq-local lsp-ui-doc-show/hide-toggle nil))
  (if lsp-ui-doc-show/hide-toggle
      (progn
        ;; active. hide action
        (lsp-ui-doc-hide)
        (setq lsp-ui-doc-show/hide-toggle nil))
    (progn
      ;; deactive. show action
      (lsp-ui-doc-show)
      (setq-local lsp-ui-doc-show/hide-toggle t))))

(use-package lsp
    :hook typescript-mode js-mode csharp-mode c++-mode go-mode js2-mode)

(use-package lsp-mode
  :init
  (require 'bind-key)
  (require 'lsp-mode)
  (add-hook 'lsp-mode-hook
            (lambda ()
              (yas-minor-mode 1)))
  (setq lsp--formatting-indent-alist
        (cons '(tsx-mode . typescript-indent-level) lsp--formatting-indent-alist))
  (bind-keys
   ("C-c RET" . lsp-execute-code-action)
   ("C-c C-x C-a" . lsp-workspace-folders-add)
   ("C-c C-x C-f" . lsp-workspace-folders-open)
   ("C-c C-x C-r" . lsp-workspace-folders-remove)
   ("C-c C-x C-d" . lsp-workspace-folders-remove))
  :custom
  (gc-cons-threshold (* 128 1024 1024))
  (read-process-output-max (* 1024 1024))
  ;; debug
  (lsp-print-io nil)
  (lsp-log-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  (lsp-eslint-enable t)
  ;; general
  (lsp-auto-guess-root nil)
  (lsp-document-sync-method lsp--sync-incremental) ;; lsp--sync-none, lsp--sync-full or lsp--sync-incremental
  (lsp-diagnostics-provider :flymake)
  (lsp-enable-completion-at-point t)
  :bind
  (:map lsp-mode-map
	("C-c r". lsp-rename)
	("C-." . company-complete)
	("C-`" . flymake-goto-next-error)
    ("C-c `" . lsp-treemacs-errors-list))
  :commands lsp)

;; LSP UI tools
(use-package lsp-ui-mode
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
  :bind
  (:map lsp-mode-map
	("C-c C-r" . lsp-ui-peek-find-references)
	("C-c C-j" . lsp-ui-peek-find-definitions)
	("C-c i" . lsp-ui-peek-find-implementation)
	("M-." . xref-find-definitions)
	("C-c m" . lsp-ui-imenu)
	("C-c TAB" . lsp-ui-imenu)
	("C-c s" . lsp-ui-sideline-mode)
    ("C-*" . lsp-ui-doc-show/hide))
  :commands lsp-ui-mode
  :hook lsp-mode)
