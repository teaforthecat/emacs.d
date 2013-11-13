; look into compilation-environment variable

(add-hook 'shell-mode-hook 'dirtrack-mode)

;; maybe usefull sometime
;(setenv "PAGER" "cat")


(defun recon-shell ()
  (interactive)
  (let ((default-directory "/ssh:recon:"))
    (shell "*recon*")))

(defun stewart-shell ()
  (interactive)
  (let ((default-directory "/ssh:stewart:"))
    (shell "*stewart*")))

(defun colbert-shell ()
  (interactive)
  (let ((default-directory "/ssh:colbert:"))
    (shell "*colbert*")))

(defun citra-shell ()
  (interactive)
  (let ((default-directory "/ssh:citra:"))
    (shell "*citra*")))

(defun zeus-start ()
  (interactive)
  (shell "*zeus-start*")
  (insert "zeus start")
  (comint-send-input)
  (buffer-disable-undo))

;; needs testing:
;; (add-hook 'comint-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'comint-file-name-prefix)
;;                  (or (file-remote-p default-directory) ""))))

;; TODO: set compilation-buffer-name-function for unique names
