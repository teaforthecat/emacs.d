;; save-current-configuration
;; resume
;; wipe
;; revive:configuration-file

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
