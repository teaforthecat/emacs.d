(define-key nrepl-mode-map (kbd "C-.") 'nrepl-previous-input)

(define-key nrepl-mode-map (kbd "M-.") 'backward-kill-word)
(undefine-key nrepl-mode-map (kbd "M-.")
(define-key nrepl-mode-map (kbd "C-j") 'nrepl-jump)

