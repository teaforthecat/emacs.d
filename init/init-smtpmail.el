(setq message-send-mail-function    'smtpmail-send-it
      smtpmail-stream-type          'starttls
      smtpmail-default-smtp-server  "smtp.gmail.com"      
      smtpmail-smtp-server          "smtp.gmail.com"
      smtpmail-smtp-service         587)
