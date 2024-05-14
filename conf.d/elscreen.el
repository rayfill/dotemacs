(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'elscreen)
  (require 'elscreen-separate-buffer-list)
  (require 'ido)
  (require 'use-package))


(use-package elscreen
  :init
  (elscreen-start)
  (ido-mode)
  (elscreen-separate-buffer-list-mode)
  :config
  (advice-add 'elscreen-mode-line-update :override
              (lambda ()
                (when (elscreen-screen-modified-p 'elscreen-mode-line-update)
                  (setq elscreen-mode-line-string
                        (format "[%d/%d]" (elscreen-get-current-screen) (elscreen-get-number-of-screens)))
                  (force-mode-line-update))))
  :custom
  (elscreen-display-tab t))

