(ignore-errors (load (expand-file-name "~/quicklisp/slime-helper.el")))

(require 'cl)
(ignore-errors
  (require 'slime)
  (slime-setup '(slime-fancy))

  (defun find-sbcl-directory (base)
    (let (result)
      (walk-directory base
		      (lambda (dir entry)
			(let ((case-fold-search nil))
			  (when (string-match
				 (case (get-architecture)
				   (:windows "^sbcl\\.exe$")
				   (:linux "^sbcl$"))
				 entry)
			    (push dir result)))))
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
	       (push (append (list :exe (concat exec-dir (case (get-architecture)
							   (:windows "sbcl.exe")
							   (:linux "sbcl"))) :core)
			     it) result)))
      result))
  
  (defvar *sbcl-base-dirs* (list (case (get-architecture)
				   (:linux (expand-file-name "~/sbcl/"))
				   (:windows "C:/Apps/lisp/sbcl/"))))

  (defun get-sbcl-name (path)
    (dolist (sbcl-base-dir *sbcl-base-dirs*)
      (let ((rest-path (subseq path (length sbcl-base-dir))))
	(when (search (car *sbcl-base-dirs*) path)
	  (return (replace-regexp-in-string "^\\([^/]+\\)/.*$" "\\1" rest-path))))))

  (defun setup-slime-lisp-implementations ()
    (mapcar
     (lambda (params)
       (let ((exe (getf params :exe))
	     (core (getf params :core))
	     (name (get-sbcl-name (getf params :exe))))
	 (list (intern name)
	       (list exe "--core" core)
	       :coding-system 'utf-8-unix)))
     (apply #'append (mapcar #'find-sbcl-exec-and-cores *sbcl-base-dirs*))))

  (setq slime-lisp-implementations (setup-slime-lisp-implementations))

  (unless (zerop (length slime-lisp-implementations))
    (setq slime-default-lisp
	  (car (sort (mapcar #'car slime-lisp-implementations)
		     (lambda (l r) (string< r l))))))

  (let ((fasl-dir (expand-file-name "~/fasl/")))
    (setq slime-compile-file-options `(:fasl-directory ,fasl-dir)))

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

  (global-set-key (kbd "C-c C-x C-o") 'open-project-dir)

  (defun get-loaded-projects ()
    (eval-in-repl
     (format "%s"
	     `(cl:loop
	       :for cl-user::key :being :the :hash-key :in asdf::*defined-systems*
	       :collect cl-user::key)))) 

  (global-set-key (kbd "C-;") 'slime-selector)
  (global-set-key (kbd "C-x M-;") 'slime-selector)
  (setq slime-autodoc-use-multiline-p t))
