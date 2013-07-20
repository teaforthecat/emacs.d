(require 'w3m)
(require 'mime-w3m)

(load-file "~/.emacs.d/contrib/dmj-html-message.el")

;; (setq elmo-imap4-debug t)
;; (setq send-mail-function 'smtpmail-send-it)

(add-hook 'wl-draft-mode-hook 'auto-fill-mode 'flyspell-mode )
;;look into
;;wl-summary-auto-sync-marks

(setq wl-draft-folder   ".drafts"
      wl-trash-folder   ".trash"
      wl-fcc            ".sent")

(setq wl-fcc-force-as-read t)

(setq wl-biff-mail-image '(image :type xpm :file "/usr/local/Cellar/emacs/24.3/share/emacs/24.3/etc/images/newsticker/mark-immortal.xpm" :ascent center))

;; biff updates
;; default (setq wl-biff-check-interval 40)
(add-hook 'wl-biff-notify-hook '(lambda ()(message "NEW MAIL")))

;; Set mail-icon to be shown universally in the modeline.
(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))

;; Fields
(setq wl-draft-fields '("To:" "Cc:" "From:" "Reply-To:"))
(setq wl-message-ignored-field-list '(".*"))
(setq wl-message-visible-field-list 
      '("^To" "^Subject" "^From" "^Date" "^Cc")
      wl-message-sort-field-list
      '("^From"
        "^Subject"
        "^To"
        "^Cc"))


;; 

;; folders
(setq wl-folder-check-async  t )
(setq wl-summary-auto-refile-skip-marks nil)
(setq wl-refile-rule-alist
      '(("From"         
         ("jenkins" . ".jenkins")
         ("Chatter" . ".chatter")
         ("Restart.Script" . ".ops"))))


;;also consider:
;; `display-time-mail-face'
;; `display-time-mail-file'
;; `display-time-mail-directory'
