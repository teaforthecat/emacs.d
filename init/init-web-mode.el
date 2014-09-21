(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(setq web-mode-map (make-sparse-keymap))
(define-key web-mode-map (kbd "M-;") 'undo-tree-undo)
