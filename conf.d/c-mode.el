(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'cc-mode)
  (require 'cl-lib)
  (require 'cc-mode)
  (require 'cc-cmds)
  (require 'cc-vars))

(use-package cc-mode
  :hook
  (cc-mode . (lambda ()
			   (progn
				 :config
				 ;;  (c-set-style "gnu")  (c-set-style "cc-mode")
				 (c-set-style "linux")
				 ;; offset customizations not in my-c-style
				 (c-set-offset 'member-init-intro '+)
				 (c-set-offset 'inline-open '0)
				 (c-set-offset 'statement-cont '+)
				 (c-set-offset 'case-label '+)
				 (c-toggle-auto-hungry-state -1))))
  :custom
  ;; tab-width
  (tab-width 4)
  ;; this will make sure spaces are used instead of tabs
  (indent-tabs-mode t)
  ;; we like auto-newline and hungry-delete
  (c-basic-offset 4)
  :bind
  (:map c-mode-map
        ("\C-c\C-v\C-c" . compile)
        ("\C-c\C-v\C-d" . gdb)
        ("\C-c\C-r" . compile))
  :mode
  (("\\.h\\'" . c-mode)
   ("\\.hpp\\'" . c-mode)
   ("\\.cpp\\'" . c-mode)))
