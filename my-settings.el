;; Get rid of the startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
;; basic emacs behavior
;;(desktop-save-mode 1)
(setq confirm-nonexistent-file-or-buffer nil)
(fset 'yes-or-no-p 'y-or-n-p)
;;visuals
;;(color-theme-zen-and-art)
(progn
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0))
(display-time)

;; globals
(yas/global-mode t)
(setq w3m-use-cookies t)
(ido-mode 1)
(global-linum-mode 1)
(autopair-global-mode 1)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq browse-url-browser-function 'browse-url-firefox)
(setq uniquify-buffer-name-style 'forward)
(put 'upcase-region 'disabled nil)


;; app settings
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "teaforthecat@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
;;      smtpmail-local-domain "yourcompany.org"
)
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]") ;enable GMAIL mailbox prefix

(setq nxml-child-indent 4)
(setq edit-server-url-major-mode-alist
      '(("github\\.com" . markdown-mode)))

(setq diary-show-holidays-flag nil)
(setq diary-file "~/org/.diary")
(add-hook 'diary-hook 'appt-make-list)
(appt-activate 1)

(setq yas/snippet-dirs "~/.emacs.d/snippets")
(yas/load-directory "~/.emacs.d/el-get/django-mode/snippets")
(yas/load-directory "~/.emacs.d/snippets")
(setq flymake-gui-warnings-enabled nil)
(setq temporary-file-directory "~/.emacs.d/tmp/")

(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.hamlpy$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.rb" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))


(add-to-list 'kill-emacs-hook 'org-mobile-push)
(add-hook 'after-init-hook 'org-mobile-pull)

;;from elpa
(require 'ruby-end)
(require 'ruby-electric)
(rvm-use "1.9.3-p0" "collections")

(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))

(setq jabber-account-list
    '(("teaforthecat@gmail.com" 
       (:network-server . "talk.google.com")
       (:connection-type . ssl)
       (:port . 443)))
    jabber-chat-buffer-show-avatar nil)

(setq jabber-roster-show-bindings nil)
(setq jabber-alert-presence-message-function 'no-presence-message )
(setq jabber-alert-info-message-function 'no-info-message )


(when (require 'session nil t)
  (add-hook 'after-init-hook 'session-initialize)
  (add-to-list 'session-globals-exclude 'org-mark-ring))

;; hooks
(add-hook 'after-init-hook '(lambda () (org-agenda-list)
                              (switch-to-buffer-other-window (or (get-buffer "timelog.org")
                                                    (get-buffer "*scratch*") ))))

(add-hook 'after-init-hook 'color-theme-subtle-hacker)

(add-hook 'desktop-after-read-hook 'jabber-connect-all)
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


;; remove
;; (defun my-shell-setup ()
;;   (setq comint-prompt-regexp "^[^#$%>\n]*[#$%>] *")
;;   (setq scroll-conservatively 10))

;; ibuffer
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

(put 'dired-find-alternate-file 'disabled nil)

(server-mode t)
;; (edit-server-start)

(setq pianobar-username "chris@spysoundlab.com")
(setq pianobar-password "change")

(setq pianobar-station  "0")

(setq 
 google-calendar-user           "teaforthecat"
 google-calendar-code-directory "/home/cthompson/.emacs.d/el-get/google-emacs/google/code"
 google-calendar-directory      "~/tmp"
 google-calendar-url            (concat 
                                 "https://www.google.com/calendar/ical/ "
                                 "q2sdhhtdong98h8elt1ckrlbq8%40group.calendar.google.com/"
                                 "private-16ebe2a142b373f568f429c3ff3380e5/basic.ics")
 google-calendar-auto-update    t
 google-calendar-directory      "~/org/google_calendar")

;; (setq google-calendar-url            "https://www.google.com/calendar/ical/teaforthecat%40gmail.com/private-c4e2b6727458393cebe9f30388ca0204/basic.ics")  ;;; URL TO YOUR GOOGLE CALENDAR

(setq thesaurus-bhl-api-key "3a3713c8c6ea7c53e6c03d80ccdd3083")

;; (add-hook 'slime-repl-mode-hook
;;           (defun clojure-mode-slime-font-lock ()
;;             (let (font-lock-mode)
;;               (clojure-mode-font-lock-setup)
;;               ;; (sldb-debug nil t id) 
;;               (load-library "my-keybindings"))))
;; (featurep 'slime) => nil
(setq haml-indent-offset 2)
(provide 'my-settings)
