; look into compilation-environment variable

(add-hook 'shell-mode-hook 'dirtrack-mode)

;; maybe usefull sometime
;(setenv "PAGER" "cat")

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
