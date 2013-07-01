(require 'w3m)
(require 'mime-w3m)

(setq elmo-imap4-debug t)
;; (setq send-mail-function 'smtpmail-send-it)


;;look into
;;wl-summary-auto-sync-marks


(setq wl-fcc-force-as-read t)
(setq wl-biff-mail-image '(image :type xpm :file "/usr/local/Cellar/emacs/24.3/share/emacs/24.3/etc/images/newsticker/mark-immortal.xpm" :ascent center))

;; biff updates
;; default (setq wl-biff-check-interval 40)
(setq wl-biff-notify-hook '(lambda()(message "NEW MAIL")))


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

