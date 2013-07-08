
(defun set-cursor-color-yellow ()
            (set-cursor-color "#ffff00"))
(add-hook 'speedbar-after-create-hook
          'set-cursor-color-yellow)

(add-hook 'speedbar-mode-hook 
          '(lambda()(visual-line-mode -1)))
