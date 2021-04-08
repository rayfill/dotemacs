(require 'cl-lib)

(defun get-win32-python-path ()
  (let ((basedir "C:\\Apps"))
    (when (and (boundp 'window-system)
	       (eq window-system 'w32))
      (some #'identity
	    (mapcar (lambda (ent)
		      (let ((case-fold-search t))
			(when (string-match ".*python.*" ent)
			  (concat basedir "\\" ent))))
		    (directory-files basedir))))))

(awhen (get-win32-python-path)
       (setq python-python-command (concat it "\\" "python.exe")))

(defun inferior-python-mode-truncate-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(add-hook 'inferior-python-mode-hook
	  (lambda ()
	    (set-buffer-process-coding-system 'utf-8 'utf-8)
	    (local-set-key (kbd "C-c M-o")
			   'inferior-python-mode-truncate-buffer)))
