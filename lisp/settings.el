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

;; su as anyone on the remote machine. This means you will only ever be able to connect as "whoami"
;; (add-to-list 'tramp-default-proxies-alist
;;              '(nil nil "/ssh:%h:"))

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
                       ) t)
              ".*:\0? *"))

(setq tramp-ssh-controlmaster-options " -o ControlPath=%t.%%r@%%h:%%p -o ControlMaster=auto -o ControlPersist=yes " )


;; added "Enter Synchronous Response"
;; /usr/local/Cellar/emacs/24.5/share/emacs/24.5/lisp/net/tramp.el.gz:616

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


; replaced by projectile-ag
;(setq ffip-find-options "-not -regex \".*svn.*\" -not -path '*/.bundle/*' -not -path '*/contrib/*'")

(setq visible-bell t)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)



(setq tags-table-list '("~/.emacs.d/"  "~/.emacs.d/el-get/"))

(setq bmkp-bmenu-state-file "~/.emacs.d/tmp/bmxp-bmenu-state.el")
(setq desktop-files-not-to-save "^$") ;; do save tramp buffers
(setq desktop-restore-eager 10)       ;; load them lazily
(setq desktop-dirname "~/.emacs.d/tmp/")
(savehist-mode 1)
(setq completion-cycle-threshold 6);;omg
(setq completion-auto-help 'lazy)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; abbreviations                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default abbrev-mode t)
;; save abbreviations upon exiting xemacs
(setq save-abbrevs t)
;; set the file storing the abbreviations
(setq abbrev-file-name "~/.emacs.d/lisp/abbrev-file.el")
;; reads the abbreviations file on startup
(quietly-read-abbrev-file)



;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;;scroll window up/down by one line
;; (global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
;; (global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))


(provide 'settings)
