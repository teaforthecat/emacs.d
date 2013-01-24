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


;; from: http://curiousprogrammer.wordpress.com/2009/04/02/ibuffer/
(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))
