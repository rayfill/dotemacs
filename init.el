
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/function.el")
(load "~/.emacs.d/package.el")
(load "~/.emacs.d/install.el")

(let ((dir "~/.emacs.d/conf.d/"))
  (dolist (content (sort (directory-files dir) #'string<))
    (when (string-match "^.*\\.el$" content)
      (format "loading %s" content)
      (let ((filepath (concat dir content)))
	(format "%s" content)
	(ensure-byte-compile-file filepath)
	(load (format "%s" (concat dir content "c")))))))

(setq custom-file "~/.emacs.d/custom.el")
(ignore-errors
  (load "~/.emacs.d/custom.el"))

