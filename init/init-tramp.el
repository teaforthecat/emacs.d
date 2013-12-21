;;backups (don't leave ~ files around on remote hosts)

;; (setq tramp-debug-buffer t)
;; (setq tramp-verbose 10)

(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq tramp-backup-directory-alist backup-directory-alist)

;;autosave (don't leave # files around on remote hosts)
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave/")

(setq tramp-default-method "ssh")
(setq explicit-shell-file-name "/bin/bash") ;; for tramp remote

;; this allows sudo on ALL remote hosts
;; nil evals as all, (host user proxy)
(setq tramp-default-proxies-alist '(("foreman1"  "\\`root\\'" "/ssh:%h:")
                                    ("puppet1"  "\\`root\\'" "/ssh:%h:")
                                    ("ghost" "root" nil)
                                    (".*prod.*"   "root" nil)
                                    (nil "\\`root\\'" "/ssh:%h:")))

;; add a colon to accommodate ep root prompt set by PS1
;; example  "some prompt:" instead of the usual "some prompt$" or "some prompt#"
(setq tramp-shell-prompt-pattern
      "\\(?:^\\|
\\)[^]#$%>\n]*#?[]#:$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")


(defun sudo-tramp-file-name (filename)
  (with-parsed-tramp-file-name filename nil
    (tramp-make-tramp-file-name "sudo" user host localname )))

(defun sudo-find-file (filename &optional wildcards)
  "Calls find-file with filename with sudo-tramp-prefix prepended"
  (interactive "FFind file with sudo ")
  (let ((sudo-name (sudo-tramp-file-name filename)))
    (message "sudo-name: %s" sudo-name)
    (apply 'find-file
           (cons sudo-name (if (boundp 'wildcards) '(wildcards))))))

(defun sudo-reopen-file ()
  "Reopen file as root by prefixing its name with sudo-tramp-prefix and by clearing buffer-read-only"
  (interactive)
  (let*
      ((file-name (expand-file-name buffer-file-name))
       (sudo-name (sudo-tramp-file-name file-name)))
    (progn
      (setq buffer-file-name sudo-name)
      (rename-buffer sudo-name)
      (setq buffer-read-only nil)
      (message (concat "File name set to " sudo-name)))))

;; can't use this on a mac unless root is enabled
;; use terminal instead `sudo emacs /filename`
;; http://support.apple.com/kb/ht1528
;; http://www.emacswiki.org/emacs/TrampMode#toc28
;; (defun sudo-edit-current-file ()
;;   (interactive)
;;   (let ((position (point)))
;;     (find-alternate-file
;;      (if (file-remote-p (buffer-file-name))
;;          (let ((vec (tramp-dissect-file-name (buffer-file-name))))
;;            (tramp-make-tramp-file-name
;;             "sudo"
;;             (tramp-file-name-user vec)
;;             (tramp-file-name-host vec)
;;             (tramp-file-name-localname vec)))
;;        (concat "/sudo:root@localhost:" (buffer-file-name))))
;;     (goto-char position)))
