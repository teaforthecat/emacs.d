
;; SQL*Plus Paths for SQL Mode
;; (setenv "TNS_ADMIN" (concat (file-name-as-directory (getenv "HOME"))
;; ".tnsadmin"))
;; (setq exec-path (append exec-path '("/opt/oracle/instantclient")))

;; Save History for SQL between sessions
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
	(rval 'sql-product))
    (if (symbol-value rval)
	(let ((filename 
	       (concat "~/.emacs.d/sql/"
		       (symbol-name (symbol-value rval))
		       "-history.sql")))
	  (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
	       (symbol-name rval))))))
(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;; something buggy with sqlplus and switching buffers
(when (require 'sqlplus nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.sqp\\'" . sqlplus-mode))
  )

;;  If you want PL/SQL support also, try something like this:
(when (require 'plsql nil 'noerror)
  (setq auto-mode-alist
	(append '(("\\.pls\\'" . plsql-mode) ("\\.pkg\\'" . plsql-mode)
		  ("\\.pks\\'" . plsql-mode) ("\\.pkb\\'" . plsql-mode)
		  ("\\.sql\\'" . plsql-mode) ("\\.PLS\\'" . plsql-mode)
		  ("\\.PKG\\'" . plsql-mode) ("\\.PKS\\'" . plsql-mode)
		  ("\\.PKB\\'" . plsql-mode) ("\\.SQL\\'" . plsql-mode)
		  ("\\.prc\\'" . plsql-mode) ("\\.fnc\\'" . plsql-mode)
		  ("\\.trg\\'" . plsql-mode) ("\\.vw\\'" . plsql-mode)
		  ("\\.PRC\\'" . plsql-mode) ("\\.FNC\\'" . plsql-mode)
		  ("\\.TRG\\'" . plsql-mode) ("\\.VW\\'" . plsql-mode))
		auto-mode-alist ))
  )
