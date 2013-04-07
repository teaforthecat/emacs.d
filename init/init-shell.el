
(add-hook 'shell-mode-hook 'dirtrack-mode)


(setq comint-buffer-maximum-size 1000)

(setq tramp-default-method "ssh")
(setq explicit-shell-file-name "/bin/bash") ;; for tramp remote

(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(defun stewart-shell ()
  (interactive)
  (let ((default-directory "/ssh:stewart:"))
    (shell "*stewart*")))

(defun colbert-shell ()
  (interactive)
  (let ((default-directory "/ssh:colbert:"))
    (shell "*colbert*")))

;; needs testing:
;; (add-hook 'comint-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'comint-file-name-prefix)
;;                  (or (file-remote-p default-directory) ""))))


;; made for the zeus start command
(defun ansi-pre-command-truncate-buffer (&optional _string)
  "honor the ansi command to clear text"
  (if (string-match "\\[19A" _string)
      (progn
        (delete-region (point-min) (point-max))
        (substring _string 5))
    _string))


(add-hook 'comint-preoutput-filter-functions 'ansi-pre-command-truncate-buffer)
