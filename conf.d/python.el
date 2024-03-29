(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'cl-lib)
  (require 'auto-virtualenvwrapper)
  (require 'python))

(defun get-win32-python-path ()
  (let ((basedir "C:\\Apps"))
    (when (and (boundp 'window-system)
	           (eq window-system 'w32))
      (when (file-exists-p basedir)
        (cl-some #'identity
	             (mapcar (lambda (ent)
		                   (let ((case-fold-search t))
			                 (when (string-match ".*python.*" ent)
			                   (concat basedir "\\" ent))))
		                 (directory-files basedir)))))))

(defvar python-python-command "/usr/bin/python")
(awhen (get-win32-python-path)
       (setq python-python-command (concat it "\\" "python.exe")))

(defun inferior-python-mode-truncate-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(add-hook 'inferior-python-mode-hook
	  (lambda ()
	    (set-process-coding-system (get-buffer-process (current-buffer)) 'utf-8 'utf-8)
	    (local-set-key (kbd "C-c M-o")
			   'inferior-python-mode-truncate-buffer)))

(add-hook 'python-mode-hook #'auto-vritaulenvwrapper-activate)
