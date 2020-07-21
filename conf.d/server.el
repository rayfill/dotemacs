(unless (string-match "^GNU Emacs.*$" (emacs-version))
  (server-start))
