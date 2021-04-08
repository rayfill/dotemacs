(defun _reduce (func args &optional init-value)
  (unless init-value
    (setq init-value (car args)
	  args (cdr args)))
  (dolist (car-slot args)
    (setq init-value (funcall func init-value car-slot)))
  init-value)

(defun exists-el-file (dir)
  (_reduce (lambda (l r)
	    (or l r))
	  (mapcar (lambda (content)
		    (string-match ".*\\.el$" content))
		  (directory-files dir))))

(defun is-directory (path)
  (if (directory-files path)
      t nil))

(defun directory-traversal (dir func)
  (dolist (entry (directory-files dir t))
    (unless (string-match ".*/\\.\\(\\.\\)?$" entry)
      (when (is-directory entry)
	(funcall func entry)
	(directory-traversal entry func)))))

(defun contain-el-file (dir)
  (_reduce (lambda (l r)
	    (or l r))
	  (let ((entries (directory-files dir)))
	    (mapcar (lambda (ent)
		      (string-match ".*\\.el$" ent))
		    entries))))

(require 'cl-lib)
(ignore-errors
 (directory-traversal "~/site-lisp/"
		      (lambda (entry)
			(when (contain-el-file entry)
			  (push entry load-path)))))

(progn
  (print "load-paths: ")
  (dolist (path load-path)
    (princ (format "%s\n" path))))
