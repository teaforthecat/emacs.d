;; save-current-configuration
;; resume
;; wipe
;; revive:configuration-file
;; also try soring desktop bookmarks with C-x r K and bookmark-bmenu-list

;;;	variables to be saved are in revive:save-variables-global-default
;;;	and revive:save-variables-local-default.  If you want to save other

;;; checkout: revive:major-mode-command-alist-default

(defun ct/saved-config-alist-read ()
  (let* ((filename-pattern ".revive.\\(.*\\).el")
         (all-config-files (directory-files "~" t filename-pattern))
         (saved-config-names (-map '(lambda (f) (string-match filename-pattern f)(match-string 1 f))
                                   all-config-files )))
    (-zip saved-config-names all-config-files )))

(defun ct/save-current-configuration ()
  "using the revive library write to (and create) a file at ~/.revive.{name}.el "
  (interactive)
  (let* ((saved-config-alist (ct/saved-config-alist-read))
         (given-name (ido-completing-read "Name: " (-map 'car saved-config-alist)))
         (revive:configuration-file (or (cdr (assoc given-name saved-config-alist))
                                        (format  "~/.revive.%s.el" given-name))))
    (save-current-configuration)))

(defun ct/resume ()
  "using the revive library read from a file at ~/.revive.{name}.el "
  (interactive)
  (let* ((saved-config-alist (ct/saved-config-alist-read))
         (given-name (ido-completing-read "Name: " (-map 'car saved-config-alist)))
         (revive:configuration-file (cdr (assoc given-name saved-config-alist))))
    (resume)))

(defun ct/wipe ()
  "using the revive library truncate a file at ~/.revive.{name}.el and delete all buffers and windows and whatever wipe does"
  (interactive)
  (let* ((saved-config-alist (ct/saved-config-alist-read))
         (given-name (ido-completing-read "Name: " (-map 'car saved-config-alist)))
         (revive:configuration-file (cdr (assoc given-name saved-config-alist))))
    (wipe)))

;; Note: changed ~/.emacs.d/el-get/revive/revive.el:756
;; (cond
;;  (success
;;   (condition-case err
;;       ;; some buffers may already exist/be in use
;;       (if (not (string= (revive:prop-buffer-name x) (buffer-name)))
;;       (rename-buffer (revive:prop-buffer-name x)))
;;     (error (message (format "%s" err))))
;;   (set-mark (revive:prop-mark x))
