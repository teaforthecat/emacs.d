;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )
(setq jabber-roster-show-bindings nil)
(setq jabber-alert-presence-message-function 'no-presence-message )
(setq jabber-alert-info-message-function 'no-info-message )


(setq jabber-auto-reconnect t)

;; may want toggles
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S") 
(setq jabber-roster-show-bindings t)
(setq jabber-muc-autojoin '("devlab@conference.im.office.gdi") )

(setq jabber-account-list
      '(("cthompson@govdelivery.com")))
