;; from ~/src/wl-config.org or 
;;http://www.mail-archive.com/emacs-orgmode@gnu.org/msg20250/wlconfiguration.org

;; Tell Emacs my E-Mail address
;; Without this Emacs thinks my E-Mail is something like <myname>@ubuntu-asus
(setq user-mail-address "teaforthecat@gmail.com")

;; Uncomment the line below if you have problems with accented letters
;; (setq-default mime-transfer-level 8) ;; default value is 7

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; Most of the configuration for wanderlust is in the .wl file. The line below
;; makes sure it will be opened with emacs-lisp-mode
(add-to-list 'auto-mode-alist '("\.wl$" . emacs-lisp-mode))
(provide 'my-wl-settings)
