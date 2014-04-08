(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq nrepl-hide-special-buffers t)

(setq cider-interactive-eval-result-prefix ";; => ")

;; the only way I know how to overwrite the cider-mode key map is to comment out the define-key's in clojure-mode.el itself.

;; (define-key cider-mode-map (kbd "M-.") 'cider-jump)
;; I wish this would work:
;; (eval-after-load 'cider-mode
;;   (progn
;;     (define-key cider-mode-map (kbd "M-.") nil)
;;     (define-key cider-mode-map (kbd "C-C M-.") 'cider-jump)))
