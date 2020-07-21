(let* ((homedir (expand-file-name "~/.emacs.d/"))
       (el-get-path (concat homedir "lisp/el-get/")))
  (add-to-list 'load-path el-get-path)
  (require 'el-get nil 'no-error))
    
