(require 'guide-key)

(add-hook 'el-get-post-init-hooks '(lambda ()
                                    (require 'diminish)
                                    (guide-key-mode 1)
                                    (diminish 'guide-key-mode)))

(setq guide-key/guide-key-sequence '("\C-x 8" ;;internationalization
                                     "H-p"))  ;; smartparens
;(setq guide-key/idle-delay 0.2)
;(setq guide-key/guide-key-sequence '("\C-x r" "\C-c &" "\C-xw"))
;(setq guide-key/recursive-key-sequence-flag nil)
;(setq guide-key/popup-window-position 'bottom)
