(defvar ct/hidden-modes
  (list 'yas-minor-mode
        'eproject-mode
        'global-visual-line-mode
        'rinari-minor-mode
        'eldoc-mode))

(defun ct/hide-modes ()
  (-map 'diminish ct/hidden-modes))

(add-hook 'after-init-hook 'ct/hide-modes)
