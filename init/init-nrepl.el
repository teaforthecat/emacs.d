;(autopair-mode -1)
;(paredit-mode -1)
;(smartparens-mode)
;(smartparens-strict-mode)

(define-key nrepl-mode-map (kbd "C-.") 'nrepl-previous-input)

(define-key nrepl-mode-map (kbd "M-.") 'backward-kill-word)
;;(undefine-key nrepl-mode-map (kbd "M-."))
(define-key nrepl-mode-map (kbd "C-j") 'nrepl-jump)


(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

(setq nrepl-popup-stacktraces nil)

(add-to-list 'same-window-buffer-names "*nrepl*")
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
