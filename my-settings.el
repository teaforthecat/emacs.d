(display-time)

(global-linum-mode 1) ;linum
(show-paren-mode t) ;paren
(setq show-paren-style 'mixed) ;paren
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


(setq diary-show-holidays-flag nil)
(setq diary-file "~/org/.diary")
(add-hook 'diary-hook 'appt-make-list)
(appt-activate 1)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )


(setq temporary-file-directory "~/.emacs.d/tmp/")

(setq require-final-newline  t)  

(add-hook 'write-contents-functions 'delete-trailing-whitespace)

(add-hook 'after-init-hook '(lambda () (org-agenda-list)
                              (switch-to-buffer-other-window 
                               (or (get-buffer "timelog.org")
                                   (get-buffer "*scratch*") ))))

(add-hook 'after-init-hook 'color-theme-subtle-hacker)


(add-hook 'comint-mode-hook 
          (lambda () 
            (set (make-local-variable 'comint-file-name-prefix) 
                 (or (file-remote-p default-directory) ""))))

(add-hook 'shell-mode-hook 'dirtrack-mode)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(add-hook 'shell-mode-hook 
          (lambda () 
            (setq comint-prompt-regexp "^[^#$%>\n]*[#$%>] *")
            (setq scroll-conservatively 10)))

(put 'dired-find-alternate-file 'disabled nil)

(server-mode t)

(provide 'my-settings)
