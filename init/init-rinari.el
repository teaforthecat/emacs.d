(add-to-list 'rinari-major-modes 'magit-mode-hook )
(setq rinari-rgrep-file-endings   "*.[^l]*")
;;need to remap eval-region to something
(define-key ruby-mode-map "\C-c\C-r" nil)

;; this is actually a rails thing 
(setq rails-ui:show-mode-line nil)
