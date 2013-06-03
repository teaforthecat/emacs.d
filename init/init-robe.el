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
