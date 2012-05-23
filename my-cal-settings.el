(setq 
 holiday-general-holidays  nil
 holiday-local-holidays nil 
 holiday-christian-holidays nil
 holiday-hebrew-holidays nil
 holiday-islamic-holidays nil
 holiday-bahai-holidays nil
 holiday-oriental-holidays nil
 holiday-solar-holidays nil )

;;(holiday-fixed 7 14 "Bastille Day")

(setq new-media-ical-url
      "https://www.google.com/calendar/ical/q2sdhhtdong98h8elt1ckrlbq8%40group.calendar.google.com/private-16ebe2a142b373f568f429c3ff3380e5/basic.ics")
(require 'calfw-cal)
(require 'calfw-ical)
(require 'calfw-org)

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; orgmode source
    (cfw:cal-create-source "Orange") ; diary source
    (cfw:ical-create-source "gcal" new-media-ical-url "IndianRed") ; google calendar ICS
    ))) 
(provide 'my-cal-settings)
