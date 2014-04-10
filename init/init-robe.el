;; (undefine-key 'robe-mode-map
;;     (define-key map (kbd "M-.") 'robe-jump)
;;     (define-key map (kbd "M-,") 'pop-tag-mark)
;;     (define-key map (kbd "C-c C-d") 'robe-doc)
;;     (define-key map (kbd "C-c C-k") 'robe-rails-refresh)
;; )

(defvar robe-mode-map
  (let ((map (make-sparse-keymap)))
    ;; (define-key map (kbd "M-.") 'robe-jump)
    ;; (define-key map (kbd "M-,") 'pop-tag-mark)
    ;; (define-key map (kbd "C-c C-d") 'robe-doc)
    ;; (define-key map (kbd "C-c C-k") 'robe-rails-refresh)
    map))


;; robe replaces tags I think:
;; (setq rails-tags-command "ctags -e --Ruby-kinds=cfmF -o %s -R %s") ;;all kinds, don't append
;; (setq rails-tags-dirs '(".")) ;;all
