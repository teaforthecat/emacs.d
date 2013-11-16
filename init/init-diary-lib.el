;; Diary
(setq diary-show-holidays-flag nil) ;calendar
(setq diary-file "~/Dropbox/org/.diary") ;calendar
(add-hook 'diary-hook 'appt-make-list) ;diary-lib ;appt
(appt-activate 1) ;appt
(setq appt-display-duration     4
      appt-message-warning-time 10
      appt-display-interval     10)
;; note you can do this in diary to set a warntime:
;;   2011/06/01 12:00 Do something ## warntime 30

;; Calendar
(add-hook 'calendar-mode-hook 'diary-mark-entries)
