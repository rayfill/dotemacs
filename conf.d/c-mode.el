(setq tab-width 4)
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  ;;  (c-set-style "gnu")  (c-set-style "cc-mode")
  (c-set-style "linux")
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '+)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'statement-cont '+)
  (c-set-offset 'case-label '+)
  ;; tab-width
  (setq tab-width 4)
  ;; this will make sure spaces are used instead of tabs
  (setq indent-tabs-mode t)  
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state -1)
  (setq c-basic-offset 4)
  ;; keybindings for C, C++, and Objective-C.  We can put these in
  ;; c-mode-map because c++-mode-map and objc-mode-map inherit it
  ;;(define-key c-mode-map "\C-m" 'newline-and-indent)  ;;; match-paren  )
  (local-set-key "\C-c\C-v\C-c" 'compile)
  (local-set-key "\C-c\C-v\C-d" 'gdb)
  (local-set-key "\C-c\C-r" 'compile)
  )

;; THE following only works in Emacs 19
;; Emacs 18ers can use (setq c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq auto-mode-alist
      (cons (cons "\\.h$" 'c++-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.hpp$" 'c++-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.cpp$" 'c++-mode) auto-mode-alist))
