;;backups
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq tramp-backup-directory-alist backup-directory-alist)


(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; this allows sudo on remote ALL remote hosts
;; nil evals as all, (host user proxy)
;;(setq tramp-default-proxies-alist '((nil "\\`root\\'" "/ssh:%h:")))
;; this is from the docs:
;
;; (add-to-list 'tramp-default-proxies-alist
;;                        '(nil "\\`root\\'" "/ssh:%h:"))
;; (add-to-list 'tramp-default-proxies-alist
;;              '((regexp-quote (system-name)) nil nil))
;; don't leave ~ files around on remote hosts


;; add a colon to accommodate ep root prompt set by PS1
;; example  "some prompt:" instead of the usual "some prompt$" or "some prompt#"
(setq tramp-shell-prompt-pattern
      "\\(?:^\\|
\\)[^]#$%>\n]*#?[]#:$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")

;; (setq tramp-shell-prompt-pattern
;;        "\\(?:^\\|
;;  \\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")
;; ;;http://www.emacswiki.org/cgi-bin/wiki/TrampMode#Chris Allen
(eval-after-load "tramp"
  '(progn
     (defvar sudo-tramp-prefix 
       "/sudo:" 
       (concat "Prefix to be used by sudo commands when building tramp path "))
     (defun sudo-file-name (filename)
       (set 'splitname (split-string filename ":"))
       (if (> (length splitname) 1)
           (progn (set 'final-split (cdr splitname))
                  (set 'sudo-tramp-prefix "/sudo:")
                  )
         (progn (set 'final-split splitname)
                (set 'sudo-tramp-prefix (concat sudo-tramp-prefix "root@localhost:")))
         )
       (set 'final-fn (concat sudo-tramp-prefix (mapconcat (lambda (e) e) final-split ":")))
       (message "splitname is %s" splitname)
       (message "sudo-tramp-prefix is %s" sudo-tramp-prefix)
       (message "final-split is %s" final-split)
       (message "final-fn is %s" final-fn)
       (message "%s" final-fn)
       )

     (defun sudo-find-file (filename &optional wildcards)
       "Calls find-file with filename with sudo-tramp-prefix prepended"
       (interactive "fFind file with sudo ")      
       (let ((sudo-name (sudo-file-name filename)))
         (apply 'find-file 
                (cons sudo-name (if (boundp 'wildcards) '(wildcards))))))

     (defun sudo-reopen-file ()
       "Reopen file as root by prefixing its name with sudo-tramp-prefix and by clearing buffer-read-only"
       (interactive)
       (let* 
           ((file-name (expand-file-name buffer-file-name))
            (sudo-name (sudo-file-name file-name)))
         (progn           
           (setq buffer-file-name sudo-name)
           (rename-buffer sudo-name)
           (setq buffer-read-only nil)
           (message (concat "File name set to " sudo-name)))))))
