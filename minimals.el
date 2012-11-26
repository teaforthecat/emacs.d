(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(setq confirm-nonexistent-file-or-buffer nil)
(setq compilation-ask-about-save nil)
(setq compilation-save-buffers-predicate '(lambda () nil))
(fset 'yes-or-no-p 'y-or-n-p)

(setq flymake-gui-warnings-enabled nil)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(provide 'minimals)
