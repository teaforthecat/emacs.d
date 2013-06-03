;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )
(setq jabber-roster-show-bindings nil)
(setq jabber-alert-presence-message-function 'no-presence-message )
(setq jabber-alert-info-message-function 'no-info-message )

;; (setq jabber-account-list
;;     '(("teaforthecat@gmail.com"
;;        (:network-server . "talk.google.com")
;;        (:connection-type . ssl)
;;        (:port . 443)))
      ;; ("teaforthecat@colbert"
      ;;  (:network-server . "colbert")
      ;;  (:connection-type . ssl)
      ;;  (:port . 5223))
      ;; ("chris@colbert"
      ;;  (:network-server . "colbert")
      ;;  (:connection-type . ssl)
      ;;  (:port . 5223))
    ;; ("chris.thompson@govdelivery.com"
    ;;  (:network-server "")
    ;;  (:connection-type . )
    ;;  (:port . ))

    ;; jabber-chat-buffer-show-avatar nil)


;;(add-hook 'el-get-post-init-hooks 'jabber-connect-all)
;; Message alert hooks

;(define-jabber-alert echo "Show a message in the echo area"
;  (lambda (msg)
;    (unless (minibuffer-prompt)
;      (message "%s" msg))))

(setq starttls-extra-arguments 
      '("--insecure" "--no-ca-verification")
)

;; may want toggles
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S") 
(setq jabber-roster-show-bindings t)
(setq jabber-muc-autojoin '("devlab@conference.im.office.gdi") )

(setq jabber-account-list
      '(("cthompson@govdelivery.com")))
