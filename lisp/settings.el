;; settings.el -- personal settings

;;tramp

(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq tramp-backup-directory-alist backup-directory-alist)
;; ;;autosave (don't leave # files around on remote hosts)
(setq tramp-auto-save-directory "~/.emacs.d/tmp/tramp-autosave/")
(setq tramp-default-method "ssh")
(setq explicit-shell-file-name "/bin/bash") ;; for tramp remote

;; on all hosts, sudo method uses this proxy
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))

;; vagrant
(add-to-list 'tramp-default-proxies-alist
             '("local.gdi" "\\`root\\'" "/ssh:vagrant@%h:"))
(add-to-list 'tramp-default-proxies-alist
             '(".dev" "\\`root\\'" "/ssh:vagrant@%h:"))

;; two-factor auth
(setq password-cache nil)
(setq tramp-password-prompt-regexp
      (concat "^.*" (regexp-opt
                     '("Passphrase" "passphrase"
                       "Password" "password"
                       "Passcode" "passcode"
                       "Enter Synchronous Response") t)
              ".*:\0? *"))

;; ensure this is required
(setq tramp-ssh-controlmaster-options " -o ControlPath=%t.%%r@%%h:%%p -o ControlMaster=auto -o ControlPersist=yes " )

;;;

(setq whitespace-line-column  80
      whitespace-style '(face tabs spaces trailing lines space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark)
      require-final-newline  t)


;; load private variables
(dolist (f (directory-files "~/.emacs.d/private" t ".el$"))
  (load-file f))

;; I'm not sure Inconsolata is a big improvement on the default
;(set-face-attribute 'default nil
;                    :family "Inconsolata"
                                        ;:height 165
                                        ;:weight 'normal
;                    )



(setq ffip-find-options "-not -regex \".*svn.*\" -not -path '*/.bundle/*' -not -path '*/contrib/*'")

(setq visible-bell t)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)



(setq comint-buffer-maximum-size 1000)


(setq tags-table-list '("~/.emacs.d/"  "~/.emacs.d/el-get/"))

(setq bmkp-bmenu-state-file "~/.emacs.d/tmp/bmxp-bmenu-state.el")
(setq desktop-files-not-to-save "^$") ;; do save tramp buffers
(setq desktop-restore-eager 10)       ;; load them lazily
(setq desktop-dirname "~/.emacs.d/.desktops")
(savehist-mode 1)
(setq completion-cycle-threshold 6);;omg
(setq completion-auto-help 'lazy)





(provide 'settings)
