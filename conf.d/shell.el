(setq shell-file-name "bash")

(require 'cl)
(defun remove-from-path (func)
  (let* ((current (split-string (getenv "PATH") ";"))
	 (new (remove-if func current)))
    new))

(defun make-path-reps (lst)
  (mapconcat #'identity lst ";"))

;(make-path-reps (remove-from-path (lambda (ent)
;		    (string-match ".*cygwin.*" ent))))

(defun restruct-path (remove-func &rest new-entries)
  (append new-entries (remove-from-path remove-func)))

(defvar *enable-modes*
  '((mingw "C:\\Apps\\MinGW\\bin" "C:\\Apps\\MinGW\\msys\\1.0\\bin")
    (cygwin "C:\\Apps\\cygwin\\bin" "C:\\Apps\\cygwin\\usr\\bin")))


(defun get-remove-entries (mode)
  (apply #'append
	 (mapcar #'cdr
		 (remove-if (lambda (ent)
			      (eq mode (car ent)))
			    *enable-modes*))))

(defun enabler-gen ()
  (dolist (ent *enable-modes*)
    (let* ((mode (car ent))
	   (paths (cdr ent))
	   (removes (get-remove-entries mode)))
      (eval
       `(defun ,(intern (concat "enable-" (symbol-name mode))) ()
	  (interactive)
	  (setenv "PATH"
		  (make-path-reps
		   (restruct-path
		    (lambda (ent)
		      (or
		       ,@(mapcar (lambda (key)
				   `(string= ,key ent)) removes)))
		    ,@paths))))))))

(enabler-gen)

(defun enable-mingw ()
  (interactive)
  (setenv "PATH"
	  (make-path-reps
	   (restruct-path (lambda (ent)
			    (string-match ".*cygwin.*" ent))
			  "C:\\Apps\\MinGW\\bin"
			  "C:\\Apps\\MinGW\\msys\\1.0\\bin"))))

(defun enable-cygwin ()
  (interactive)
  (setenv "PATH"
	  (make-path-reps
	   (restruct-path (lambda (ent)
			    (string-match ".*MinGW.*" ent))
			  "C:\\Apps\\cygwin\\bin"
			  "C:\\Apps\\cygwin\\usr\\bin"))))

;(enable-cygwin)
