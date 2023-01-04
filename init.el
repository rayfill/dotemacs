
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/function.el")
(load "~/.emacs.d/package.el")
(load "~/.emacs.d/install.el")
(when (file-exists-p "~/.emacs.d/site-install.el")
  (load "~/.emacs.d/site-install.el"))

(defun compile-and-load (dir)
  (when (file-exists-p dir)
    (dolist (content (sort (directory-files dir) #'string<))
      (when (string-match "^[^.].*\\.el$" content)
	    (format "loading %s" content)
	    (let* ((filepath (concat dir content))
               (elc-filepath (concat filepath "c")))
	      (format "%s" content)
	      (ensure-byte-compile-file filepath)
	      (load (format "%s" elc-filepath)))))))

(compile-and-load "~/.emacs.d/requires.d/")

(compile-and-load "~/.emacs.d/conf.d/")
(when (file-exists-p "~/.emacs.d/site-conf.d/")
  (compile-and-load "~/.emacs.d/site-conf.d/"))

(setq custom-file "~/.emacs.d/custom.el")
(ignore-errors
  (load "~/.emacs.d/custom.el"))

(setq kill-emacs-query-functions
      (append kill-emacs-query-functions
	      (lambda () (y-or-n-p "quit emacs?"))))

(when (file-exists-p "~/.emacs.d/user.d/")
  (compile-and-load "~/.emacs.d/user.d/"))
(when (file-exists-p "~/.emacs.d/site-user.d/")
  (compile-and-load "~/.emacs.d/site-user.d/"))
