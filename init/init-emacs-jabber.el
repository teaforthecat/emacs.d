;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )

(setq jabber-account-list
    '(("teaforthecat@gmail.com" 
       (:network-server . "talk.google.com")
       (:connection-type . ssl)
       (:port . 443)))
    jabber-chat-buffer-show-avatar nil)

(setq jabber-roster-show-bindings nil)
(setq jabber-alert-presence-message-function 'no-presence-message )
(setq jabber-alert-info-message-function 'no-info-message )

(add-hook 'el-get-post-init-hooks 'jabber-connect-all)
