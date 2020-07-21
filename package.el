(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(package-install 'exec-path-from-shell)
(package-install 'use-package)
