(cl-eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'sql))
;(sql-sqlite)
(setq sql-sqlite-program "/usr/bin/sqlite3")
