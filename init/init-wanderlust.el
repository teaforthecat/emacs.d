(require 'w3m)
(require 'mime-w3m)

;; think about moving into the directory
(setq wl-folders-file "~/.emacs.d/.folders")
(setq wl-user-mail-address-list (quote ("teaforthecat@gmail.com"
                                        "chris.thompson@spysoundlab.com"
                                        "chris.at.walker@gmail.com")))
(defun teaforthecat (folder-name)
  (concat "%" folder-name ":" "\"teaforthecat\"/clear@imap.gmail.com:993!"))

(defun chris-at-walker (folder-name)
  (concat "%" folder-name ":" "\"chris.at.walker\"/clear@imap.gmail.com:993!"))

;; How messages with disposal mark ("d") are to be handled.
;; remove = instant removal (same as "D"), trash = move to wl-trash-folder
;; string = move to string.
(setq wl-dispose-folder-alist
      '(("^%.*teaforthecat.*" . trash)
        ("^%.*spy.*" . trash)
        ("^%.*chris\\.at\\.walker" .  trash)
        ))

;;select correct email address when we _start_ writing a draft.
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)

;;is run when wl-draft-send-and-exit or wl-draft-send is invoked:
;;(NOTE: "M-: wl-draft-parent-folder" => %INBOX:myname/clear@imap.gmail.com:993)
(setq wl-draft-config-alist
      '(((string-match "chris.at.walker" wl-draft-parent-folder)
         (template . "work")
         (wl-smtp-posting-user . "chris.at.walker")
         (wl-smtp-posting-server . "smtp.gmail.com")
         (wl-smtp-authenticate-type ."plain")
         (wl-smtp-connection-type . 'starttls)
         (wl-smtp-posting-port . 587)
         (wl-local-domain . "gmail.com")
         (wl-draft-folder . "+draft"))
        ((string-match "teaforthecat" wl-draft-parent-folder)
         (template . "teaforthecat"))
        ((string-match "spysoundlab" wl-draft-parent-folder)
         (template . "spy")
         (wl-smtp-posting-user . "chris.thompson@spysoundlab.com")
         (wl-smtp-posting-server . "box715.bluehost.com")
         (wl-smtp-authenticate-type . "login")
         (wl-smtp-connection-type . 'ssl)
         (wl-smtp-posting-port . 465)
         (wl-draft-folder . "+draft")
         (wl-local-domain . "spysoundlab.com"))))

;; biff does not work with gmail
(setq wl-biff-check-folder-list 
      '("%Inbox:\"chris.thompson+spysoundlab.com\"/clear@box715.bluehost.com:993!") )

;;choose template with C-c C-j
(setq wl-template-alist
      '(("teaforthecat"
         (wl-from . "Chris Thompson <teaforthecat@gmail.com>")
         (wl-smtp-posting-user . "teaforthecat")
         (wl-smtp-posting-server . "smtp.gmail.com")
         (wl-smtp-authenticate-type ."plain")
         (wl-smtp-connection-type . 'starttls)
         (wl-smtp-posting-port . 587)
         (wl-draft-folder . "+draft")
         (wl-local-domain . "gmail.com")
         ("From" . wl-from))
        ("work"
         (wl-from . "Chris Thompson <chris.at.walker@gmail.com>")
         ("From" . wl-from))
        ("spy"
         (wl-from . "Chris Thompson <chris.thompson@spysoundlab.com>")
         ("From" . wl-from))))

;; Use different signature files based on From: address
(setq signature-file-alist
      `((("From" . "chris.at.walker@gmail.com") . 
         ,(expand-file-name "~/.emacs.d/signature.d/chris.at.walker@gmail.com"))
        (("From" . "teaforthecat@gmail.com") . 
         ,(expand-file-name "~/.emacs.d/signature.d/teaforthecat@gmail.com"))))


;; mark sent messages (folder carbon copy) as read.
(setq wl-fcc-force-as-read    t)

;;Only save draft when I tell it to! (C-x C-s or C-c C-s):
;;(arg: seconds of idle time untill auto-save).
(setq wl-auto-save-drafts-interval nil)
(setq wl-generate-mailer-string-function 'wl-generate-user-agent-string-1)

(setq wl-message-ignored-field-list '(".*"))
(setq wl-message-visible-field-list 
      '("^To" "^Subject" "^From" "^Date" "^Cc")
      wl-message-sort-field-list
      '("^From"
        "^Subject"
        "^To"
        "^Cc"))

;; mail compose
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq wl-draft-fields '("To:" "Cc:" "From:" "Reply-To:"))

(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))

;;default smtp
(setq wl-smtp-posting-server "box715.bluehost.com"
      wl-smtp-posting-user "chris.thompson@spysoundlab.com"
      wl-from "Chris Thompson <chris.thompson@spysoundlab.com>"
      wl-smtp-authenticate-type  "login"
      wl-local-domain "spysoundlab.com"
;;      wl-message-id-domain "spysoundlab.com"
      wl-smtp-authenticate-type "login"
      wl-smtp-connection-type 'ssl
      wl-smtp-posting-port 465
      wl-draft-folder "+draft")

