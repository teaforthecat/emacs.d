;; from: idle-hightlight-mode.el
;; Example:
;;
(defun my-coding-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t))

(add-hook 'emacs-lisp-mode-hook 'my-coding-hook)
(add-hook 'ruby-mode-hook 'my-coding-hook)
(add-hook 'ruby-mode-hook 'idle-highlight-mode) ;;might be working
(add-hook 'js2-mode-hook 'my-coding-hook)

(setq idle-highlight-idle-time 1)
