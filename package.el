(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(unless package--initialized
  (package-initialize))
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

