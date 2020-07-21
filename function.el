(defmacro awhen (expr &rest body)
  `(let ((it ,expr))
     (when it
       ,@body)))

(defmacro aif (expr then-body else-body)
  `(let ((it ,expr))
     (if it
	 then-body
       else-body)))

(defun get-architecture ()
  (interactive)
  (cond
     ((eq system-type 'gnu/linux) :linux)
     ((eq system-type 'windows-nt) :windows)
     ((eq system-type 'cygwin) :cygwin)
     ((eq system-type 'darwin) :darwin)))

(require 'cl)
(defun ensure-mkdir (dir)
  (unless (ignore-errors (directory-files dir))
    (mkdir dir)))

(defun parent-dir (dir)
  (replace-regexp-in-string "\\(.*/\\)[^/]+/?" "\\1" dir))

(defun walk-directory (base-dir fn)
  (dolist (content (directory-files-and-attributes base-dir))
    (let ((entry (car content))
	  (is-dir (cadr content))
	  (separator (if (string-match ".*/$" base-dir) "" "/")))
      (if is-dir
	  (or (string-match "^[.]$" entry)
	      (string-match "^[.][.]$" entry)
	      (let ()
		(walk-directory (concat base-dir separator entry) fn)))
	(funcall fn (concat base-dir separator) entry)))))

(defun ensure-string (string-designator)
  (typecase string-designator
    (string string-designator)
    (symbol (symbol-name string-designator))
    (t (error "can't convert for string: %s" string-designator))))

(defun ensure-keyword (keyword-designator)
  (typecase keyword-designator
    (keyword keyword-designator)
    (symbol (intern (concat ":" (symbol-name keyword-designator))))
    (string (intern (concat ":" keyword-designator)))
    (t (error "can't convert for keyword: %s" keyword-designator))))

(defun get-completion-entries (input completion-list)
  (let* ((input input)
	 (comp-list completion-list)
	 (result (all-completions input comp-list)))
    (if (= (length result) 1)
	(list t result)
      (list (car (member input result)) result))))

(defun require-byte-compile-p (filename)
  (let* ((pathname (expand-file-name filename))
	 (bytecompile-pathname (byte-compile-dest-file pathname)))
    (unless (file-exists-p filename)
      (error (format "file not found: %s" filename)))
    (or
     (not (file-exists-p bytecompile-pathname))
     (file-newer-than-file-p pathname bytecompile-pathname))))

(defun ensure-byte-compile-file (filename)
  (let ((pathname (expand-file-name filename)))
    (when (require-byte-compile-p pathname)
      (byte-compile-file pathname))))
