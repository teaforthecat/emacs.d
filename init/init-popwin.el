(popwin-mode 1)

;; M-!
(push "*Shell Command Output*" popwin:special-display-config)
(push '(dired-mode :width 80 :position left) popwin:special-display-config)
(assq-delete-all 'grep-mode popwin:special-display-config)
(push '(grep-mode  :noselect nil) popwin:special-display-config)

 ;; (grep-mode :noselect t)
 ;; (occur-mode :noselect t)



;; undo-tree
(push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config)
