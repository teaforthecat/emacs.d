(require 'jabber-util)
(require 'auth-source)
(require 'password-cache)
(require 'jabber-bookmarks)

;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )
(setq jabber-roster-show-bindings nil)
(setq jabber-alert-presence-message-function 'no-presence-message )
(setq jabber-alert-info-message-function 'no-info-message )
(setq jabber-roster-show-bindings nil)
;; (setq jabber-alert-info-message-hooks nil)
;; need to know about message in mode line
;; (setq jabber-alert-message-hooks '(jabber-message-scroll))
(setq jabber-alert-muc-hooks '(jabber-muc-scroll))

(setq jabber-chat-fill-long-lines nil)

(setq jabber-auto-reconnect t)

;; may want toggles
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S")

(if (boundp 'GD-jid)  ;;private is loaded
    (progn
      (setq jabber-muc-autojoin
            (list GD-devlab GD-deploystatus GD-scrum_a))
      (setq jabber-account-list
            (list (list GD-jid)))
      ;; pre-cache password using auth-source and password-cache
      (password-cache-add (jabber-password-key GD-jid)
                          (funcall (plist-get (car
                                               (auth-source-search :host GD-host))
                                              :secret)) )))

;; inline customization added:
;; /Users/cthompson/.emacs.d/el-get/jabber/jabber-sasl.el:46
;; +                   nil                  ;HACK: stop prompt, never use anonymous auth

;; /Users/cthompson/.emacs.d/el-get/jabber/jabber-sasl.el:77
;; - (yes-or-no-p "Jabber server only allows cleartext password transmission!  Continue? ")
