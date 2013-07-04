(add-to-list 'rinari-major-modes 'magit-mode-hook )
(setq rinari-rgrep-file-endings   "*.[^l]*")
(define-key ruby-mode-map "\C-c\C-r" nil)

;; this is actually a rails thing 
(setq global-mode-string (remove 'rails-ui:mode-line global-mode-string))

