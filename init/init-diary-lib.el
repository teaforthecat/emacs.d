;; Diary
(setq diary-show-holidays-flag nil) ;calendar
(setq diary-file "~/Dropbox/org/.diary") ;calendar
(add-hook 'diary-hook 'appt-make-list) ;diary-lib ;appt
(appt-activate 1) ;appt

