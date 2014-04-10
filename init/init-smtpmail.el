(setq message-send-mail-function    'smtpmail-send-it
      smtpmail-stream-type          'starttls
      smtpmail-default-smtp-server  "smtp.gmail.com"
      smtpmail-smtp-server          "smtp.gmail.com"
      smtpmail-smtp-service         587)

;; Mail
;; uses ~/.authinfo
(setq
 smtpmail-starttls-credentials '(("smtp.gmail.com" "587" nil nil))
 smtpmail-auth-credentials  (expand-file-name "~/.authinfo")
 smtpmail-default-smtp-server "smtp.gmail.com")
