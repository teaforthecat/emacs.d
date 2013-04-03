
(add-hook 'shell-mode-hook 'dirtrack-mode)


(setq comint-buffer-maximum-size 1000)

(setq tramp-default-method "ssh")
(setq explicit-shell-file-name "/bin/bash") ;; for tramp remote

(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(defun stewart-shell ()
  (let ((default-directory "/ssh:stewart:"))
    (shell "*stewart*")))

(defun colbert-shell ()
  (let ((default-directory "/ssh:colbert:"))
    (shell "*colbert*")))

;; needs testing:
;; (add-hook 'comint-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'comint-file-name-prefix)
;;                  (or (file-remote-p default-directory) ""))))
