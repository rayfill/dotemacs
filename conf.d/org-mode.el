(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'use-package)
  (require 'org)
  (require 'org-download)
  (require 'org-attach-screenshot)
  (require 'cl-lib))

(use-package org-attach-screenshot
  :bind ("<f10>" . org-attach-screenshot)
  :config (setq org-attach-screenshot-dirfunction
                (lambda ()
                  (progn (cl-assert (buffer-file-name))
                         (concat (file-name-sans-extension (file-name-directory (buffer-file-name)))
                                 )))
                org-attach-screenshot-command-line "gnome-screenshot -a -f %f"))

