(cl-eval-when (:compile :load :execute)
  (require 'elscreen)
  (require 'elscreen-separate-buffer-list)
  (require 'ido)
  (require 'use-package))


(use-package elscreen
  :init
  (elscreen-start)
  (elscreen-separate-buffer-list-mode)
  (ido-mode)
  :custom
  (elscreen-display-tab nil))

