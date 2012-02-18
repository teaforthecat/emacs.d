;;lots of playing around 
;;there are no settings in here that are really in use
(require 'mime-w3m)
(require 'octet)
(octet-mime-setup)
;;
(setq
 wl-icon-directory "/home/cthompson/.emacs.d/el-get/wanderlust/icons"
 wl-interactive-send t
 mime-edit-split-message nil
 wl-message-id-use-wl-from 1
 wl-stay-folder-window t
 wl-folder-window-width 30
 wl-folder-desktop-name "Mail"
 wl-plugged t
 wl-folder-check-async t
 wl-user-mail-address-list (list "Chris Thompson <teaforthecat@gmail.com>"
                                 "Chris Thompson <chris@spysoundlab.com>"
                                 "Chris Thompson <chris.thompson@walkerart.org>"))


(setq wl-message-id-domain "chris.thompson@walkerart.org")
(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))

;;(add-hook 'wl-biff-notify-hook 'my-wl-update-current-summaries)
;;(setq wl-mode-line-display-priority-list '(biff title plug))
;;remove duplicate icon
;;(setq wl-mode-line-display-priority-list '(title plug))

;;biff
(setq 
    wl-biff-check-folder-list '(
                                "%Inbox:chris.at.walker+gmail.com/clear@imap.gmail.com:993!"
                                "+~/Maildir/spysoundlab" 
                                "+~/Maildir/list-serves"
                                "+~/Maildir/teaforthecat"
                                "+~/Maildir/teaforthecat/all"
                                ".~/Maildir/errors/new"
                                ".~/Mail/new"
                                )
    wl-biff-check-interval 5
;    wl-biff-notify-hook '(my-wl-update-current-summaries)
    wl-biff-use-idle-timer nil)


;;
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; ignore  all fields
(setq wl-message-ignored-field-list '("^.*:"))
;; ..but these five
(setq wl-message-visible-field-list
'("^To:"
  "^Cc:"
  "^From:"
  "^Subject:"
  "^Date:"))
(setq wl-message-sort-field-list
 '("^From:"
   "^Subject:"
   "^Date:"
   "^To:"
   "^Cc:"))

;; use wl for default compose-mail
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq wl-draft-config-alist
      '(((string-match "gmail" wl-draft-parent-folder)
         ("From" . (car wl-user-mail-address-list) ))
        ((string-match "spy" wl-draft-parent-folder)
         ("From" . (car (cdr wl-user-mail-address-list)) ))
        ((string-match "walker" wl-draft-parent-folder)
         ("From" . (car (cdr (cdr wl-user-mail-address-list))) ))
         ))


(add-hook 'wl-mail-setup-hook 'flyspell-mode)
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)
(add-hook 'wl-draft-reedit-hook 'wl-draft-config-exec)



(defun my-wl-update-current-summaries ()
  (let ((buffers (wl-collect-summary)))
    (while buffers
      (with-current-buffer (car buffers)
        (save-excursion
          (wl-summary-sync-update)))
      (setq buffers (cdr buffers)))))


(defun switch-smtp-servers (arg)
  (interactive "sserver(s or g or w):")
  (if (string= arg "s") (progn
       (setq wl-smtp-connection-type nil)
       (setq wl-smtp-posting-port 26)
       (setq wl-smtp-authenticate-type "plain")
       (setq wl-smtp-posting-user "chris@spysoundlab.com")
       (setq wl-smtp-posting-server "mail.spysoundlab.com")
       (setq wl-local-domain "spysoundlab.com")
       (setq wl-from "chris@spysoundlab.com")
       (setq wl-envelope-from "chris@spysoundlab.com")
       (message "using spysoundlab"))
       )
  (if (string= arg "g") (progn
       (setq wl-smtp-connection-type 'starttls)
       (setq wl-smtp-posting-port 587)
       (setq wl-smtp-authenticate-type "plain")
       (setq wl-smtp-posting-user "teaforthecat")
       (setq wl-smtp-posting-server "smtp.gmail.com")
       (setq wl-local-domain "gmail.com")
       (setq wl-from "teaforthecat@gmail.com")
       (setq wl-envelope-from "teaforthecat@gmail.com")
       (message "using gmail")
       ))
(if (string= arg "w") (progn
     (setq wl-smtp-connection-type 'starttls)
     (setq wl-smtp-posting-port 587)
     (setq wl-smtp-authenticate-type "plain")
     (setq wl-smtp-posting-user "chris.at.walker")
     (setq wl-smtp-posting-server "smtp.gmail.com")
     (setq wl-local-domain "gmail.com")
     (setq wl-from "chris.thompson@walkerart.org")
     (setq wl-envelope-from "chris.thompson@walkerart.org")
     (message "using walker-gmail")
     ))
)

;;(switch-smtp-servers "g")
;;
;;(elmo-password-alist-save)
;;(elmo-password-alist-clear)
;;
;; (setq wl-generate-mailer-string-function nil)
;; (setq wl-draft-additional-header-alist
;;       (list
;;        (cons 'X-Mailer (lambda () (product-string-1 'wl-version)))))


;; (setq elmo-split-rule
;;       ;; Store messages from spammers into `+junk'
;;       '(((or (address-equal from "i.am@spammer")
;; 	     (address-equal from "dull-work@dull-boy")
;; 	     (address-equal from "death-march@software")
;; 	     (address-equal from "ares@aon.at")
;; 	     (address-equal from "get-money@richman"))
;; 	 "+junk")
;; 	;; Store messages from mule mailing list into `%mule'
;; 	((equal x-ml-name "mule") "%mule")
;; 	;; Store messages from wanderlust mailing list into `%wanderlust'
;; 	;; and continue evaluating following rules
;; 	((equal x-ml-name "wanderlust") "%wanderlust" continue)
;; 	;; Store messages from Yahoo user into `+yahoo-{username}'
;; 	((match from "\\(.*\\)@yahoo\\.com")
;; 	 "+yahoo-\\1")
;; 	;; Store unmatched mails into `+inbox'
;; 	(t "+inbox")))

;; (setq wl-subscribed-mailing-list
;;       '("wl@lists.airs.net"
;;         "apel-ja@m17n.org"
;;         "emacs-mime-ja@m17n.org"))

;(setq wl-summary-always-sticky-folder-list t)
;; (setq wl-summary-line-format "%n%T%P %D/%M (%W) %h:%m %t%[%25(%c %f%) %] %s")
;; (setq wl-summary-width 150)
;; (setq wl-user-mail-address-list (quote ("teaforthecat@gmail.com" "chris@spysoundlab.com")))

;; ;; NNTP server for news posting. Default: nil
;; (setq wl-folder-summary-line-format-alist
;;       '(("^%" . "%T%P%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")
;;         ("^+" . "%n%T%P%M/%D %[ %17f %] %t%C%s")))
;; (wl)


;;elmo
(setq
elmo-maildir-folder-path "~/Mail"
elmo-mh-folder-path "~/Mail"
elmo-message-fetch-confirm nil
elmo-message-fetch-threshold 250000
elmo-folder-update-confirm nil
elmo-folder-update-threshold 1000)



;; IMAP GMAIL
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "chris.at.walker@gmail.com") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t) 
;; IMAP SPY   
;; I don't think this one works
;; (setq
;;  elmo-imap4-default-server "box715.bluehost.com"
;;  elmo-imap4-default-user "chris@spysoundlab.com" 
;;  elmo-imap4-default-authenticate-type 'clear
;;  elmo-imap4-default-port '993
;;  elmo-imap4-default-stream-type 'ssl
;;  elmo-imap4-use-modified-utf7 t)
;; possible icons:
;; wl-access-folder-icon 	wl-archive-folder-icon
;; wl-biff-mail-icon 	wl-biff-nomail-icon
;; wl-closed-group-folder-icon 	wl-demo-icon-name-alist
;; wl-draft-folder-icon 	wl-empty-trash-folder-icon
;; wl-file-folder-icon 	wl-filter-folder-icon
;; wl-folder-internal-icon-list 	wl-folder-toggle-icon-list
;; wl-highlight-folder-with-icon 	wl-imap-folder-icon
;; wl-internal-folder-icon 	wl-localdir-folder-icon
;; wl-localnews-folder-icon 	wl-maildir-folder-icon
;; wl-multi-folder-icon 	wl-nntp-folder-icon
;; wl-opened-group-folder-icon 	wl-pipe-folder-icon
;; wl-plugged-icon 	wl-pop-folder-icon
;; wl-queue-folder-icon 	wl-search-folder-icon
;; wl-shimbun-folder-icon 	wl-trash-folder-icon
;; wl-unplugged-icon
;


;global variable ‘dmj/wl-send-html-message-toggled-p’ to the string “HTML” to enable html messages by default.
;;(setq dmj/wl-send-html-message-toggled-p "HTML")
(setq dmj/wl-send-html-message-toggled-p nil)
(defun dmj/wl-send-html-message ()
  "Send message as html message.
  Convert body of message to html using
  `org-export-region-as-html'."
  (require 'org)
  (save-excursion
    (let (beg end html text)
      (goto-char (point-min))
      (re-search-forward "^--text follows this line--$")
      ;; move to beginning of next line
      (beginning-of-line 2)
      (setq beg (point))
      (if (not (re-search-forward "^--\\[\\[" nil t))
          (setq end (point-max))
        ;; line up
        (end-of-line 0)
        (setq end (point)))
      ;; grab body
      (setq text (buffer-substring-no-properties beg end))
      ;; convert to html
      (with-temp-buffer
        (org-mode)
        (insert text)
        ;; handle signature
        (when (re-search-backward "^-- \n" nil t)
          ;; preserve link breaks in signature
          (insert "\n#+BEGIN_VERSE\n")
          (goto-char (point-max))
          (insert "\n#+END_VERSE\n")
          ;; grab html
          (setq html (org-export-region-as-html
                      (point-min) (point-max) t 'string))))
      (delete-region beg end)
      (insert
       (concat
        "--" "<<alternative>>-{\n"
        "--" "[[text/plain]]\n" text
        "--" "[[text/html]]\n"  html
        "--" "}-<<alternative>>\n")))))

(defun dmj/wl-send-html-message-toggle ()
  "Toggle sending of html message."
  (interactive)
  (setq dmj/wl-send-html-message-toggled-p
        (if dmj/wl-send-html-message-toggled-p
            nil "HTML"))
  (message "Sending html message toggled %s"
           (if dmj/wl-send-html-message-toggled-p
               "on" "off")))

(defun dmj/wl-send-html-message-draft-init ()
  "Create buffer local settings for maybe sending html message."
  (unless (boundp 'dmj/wl-send-html-message-toggled-p)
    (setq dmj/wl-send-html-message-toggled-p nil))
  (make-variable-buffer-local 'dmj/wl-send-html-message-toggled-p)
  (add-to-list 'global-mode-string
               '(:eval (if (eq major-mode 'wl-draft-mode)
                           dmj/wl-send-html-message-toggled-p))))

(defun dmj/wl-send-html-message-maybe ()
  "Maybe send this message as html message.

If buffer local variable `dmj/wl-send-html-message-toggled-p' is
non-nil, add `dmj/wl-send-html-message' to
`mime-edit-translate-hook'."
  (if dmj/wl-send-html-message-toggled-p
      (add-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)
    (remove-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)))

(add-hook 'wl-draft-reedit-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-mail-setup-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-draft-send-hook 'dmj/wl-send-html-message-maybe)

(provide 'my-wl-settings)
