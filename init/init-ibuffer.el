(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-default-sorting-mode 'filename)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("colbert" (filename . ".*colbert\\.walkerart.*"))
	       ("python" (mode . python-mode))
	       ("Ruby" (mode . ruby-mode))
	       ("dired" (mode . dired-mode))
	       ("shell" (or
			 (name . "^\\*shell\\*$")
			 (mode . shell-mode)))
	       ("planner" (or
			   (name . "^\\*Calendar\\*$")
			   (name . "^diary$")
			   (mode . org-mode)))
	       ("emacs" (or
			 (mode . emacs-lisp)
			 (name . ".el$")
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))))))
