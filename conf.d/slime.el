(cl-eval-when (:compile :load :execute)
  (ignore-errors
    (load (expand-file-name "~/quicklisp/slime-helper.el"))
    (require 'slime)))

(require 'cl-lib)
(defun find-sbcl-directory (base)
  (let (result)
    (when (file-exists-p  base)
      (walk-directory base
		      (lambda (dir entry)
			(let ((case-fold-search nil))
			  (when (string-match
				 (case (get-architecture)
				   (:windows "^sbcl\\.exe$")
				   (:linux "^sbcl$"))
				 entry)
			    (push dir result))))))
    result))

(defun find-core (dir)
  (let (result)
    (walk-directory dir
		    (lambda (dir entry)
		      (let ((case-fold-search nil))
			(when (string-match "^sbcl\\.core$" entry)
			  (push (concat dir entry) result)))))
    (if result
	result
      (let ((pdir (parent-dir dir)))
	(unless (string= pdir "/")
	  (find-core pdir))))))

(defun find-sbcl-exec-and-cores (basedir)
  (let (result)
    (dolist (exec-dir (find-sbcl-directory basedir))
      (awhen (find-core exec-dir)
	     (push
	      (append
	       (list :exe
		     (concat exec-dir
			     (case (get-architecture)
			       (:windows "sbcl.exe")
			       (:linux "sbcl"))) :core) it)
	      result)))
    result))

(defvar *sbcl-base-dirs* (list (case (get-architecture)
				 (:linux (expand-file-name "~/sbcl/"))
				 (:windows "C:/Apps/lisp/sbcl/"))))

(defun get-sbcl-name (path)
  (dolist (sbcl-base-dir *sbcl-base-dirs*)
    (let ((rest-path (cl-subseq path (length sbcl-base-dir))))
      (when (cl-search (car *sbcl-base-dirs*) path)
	(return (replace-regexp-in-string "^\\([^/]+\\)/.*$" "\\1" rest-path))))))

(defun setup-slime-lisp-implementations ()
  (mapcar
   (lambda (params)
     (let ((exe (cl-getf params :exe))
	   (core (cl-getf params :core))
	   (name (get-sbcl-name (cl-getf params :exe))))
       (list (intern name)
	     (list exe "--core" core)
	     :coding-system 'utf-8-unix)))
   (apply #'append (mapcar #'find-sbcl-exec-and-cores *sbcl-base-dirs*))))

(defun eval-in-repl (expr)
    (destructuring-bind (output value)
	(slime-eval `(swank:eval-and-grab-output ,(format "%s" expr)))
      value))

(defun get-project-dir (project)
  (let ((project (ensure-keyword project)))
    (eval-in-repl
     (format "%s"
	     `(cl:ignore-errors
	       (cl:flet
		((get-project-dir
		  (project)
		  (cl:namestring
		   (cl:make-pathname
		    :defaults (asdf::%system-source-file
			       (asdf:find-system project))
		    :name nil :type nil))))
		(cl-user::get-project-dir ',project)))))))

(defun open-project-dir (project)
  (interactive "M")
  (let ((project-dir (read (get-project-dir project))))
    (if project-dir
	(dired project-dir)
      (message "project not found."))))

(defun get-loaded-projects ()
  (eval-in-repl
   (format "%s"
	   `(cl:loop
	     :for cl-user::key :being :the :hash-key :in asdf::*defined-systems*
	     :collect cl-user::key))))

(use-package slime
  :init
  (slime-setup '(slime-fancy))

  :custom
  (slime-lisp-implementations (setup-slime-lisp-implementations))
  (slime-autodoc-use-multiline-p t)

  :bind
  (:map slime-mode-map
	("C-c C-x C-o" . open-project-dir)
	("C-;" . slime-selector)
	("C-x M-;" . slime-selector)))

(unless (zerop (length slime-lisp-implementations))
  (setq slime-default-lisp
	(car (sort (mapcar #'car slime-lisp-implementations)
		   (lambda (l r) (string< r l))))))

(let ((fasl-dir (expand-file-name "~/fasl/")))
  (setq slime-compile-file-options `(:fasl-directory ,fasl-dir)))
