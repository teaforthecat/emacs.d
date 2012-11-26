(setq org-agenda-include-diary t)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-directory "~/org/")
(setq org-remember-templates (quote (
                                     ( "Task" 116 "* TODO %?
   %u" "~/org/todo.org" "Tasks")
                                     ("Walker Schedule" 119 "* TODO %?    
   %u  " "~/org/walker_schedule.org" "Walker Schedule" nil)
                                     ("TODO" 120 "* TODO %?    
   %u  " nil "TODO" nil)
                                     ("Note" 110 "* 
   %u %?" "~/org/notes.org" "Notes"))))

;; ;; the 'w' corresponds with the 'w' used before as in:
;;   emacsclient \"org-protocol:/capture:/w/  [...]
(setq org-capture-templates
  '(
     ("w" "" entry ;; 'w' for 'org-protocol'
       (file+headline "www.org" "Notes")
       "* %^{Title}\n\n  Source: %u, %c\n\n  %i")
     ;; other templates
))



(setq org-agenda-files '("~/org/agendas/user-groups.org"
                         "~/org/agendas/walker.org"))
;;redundant?
(setq org-directory "~/org")

;; (setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(add-to-list 'kill-emacs-hook 'org-mobile-push)
(add-hook 'after-init-hook 'org-mobile-pull)

;; damn
;; (setq org-agenda-custom-commands '(quote ("d" todo "DELEGATED" nil)
;;                                      ("c" todo "DONE|DEFERRED|CANCELLED" nil)
;;                                      ("w" todo "WAITING" nil)
;;                                      ("W" agenda "" ((org-agenda-ndays 21)))
;;                                      ("A" agenda "" ((org-agenda-skip-function 
;;                                                       (lambda nil (org-agenda-skip-entry-if 
;;                                                                    (quote notregexp) "\\=.*\\[#A\\]")))
;;                                                      (org-agenda-ndays 1)
;;                                                      (org-agenda-overriding-header "Today's Priority #A tasks: ")))
;;                                      ("u" alltodo "" ((org-agenda-skip-function
;;                                                        (lambda nil (org-agenda-skip-entry-if
;;                                                                     (quote scheduled)
;;                                                                     (quote deadline)
;;                                                                     (quote regexp) "<[^>]+>")))
;;                                                       (org-agenda-overriding-header "Unscheduled TODO entries: ")))))
;; )
(setq 
 org-agenda-ndays 30
 org-agenda-show-all-dates t
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-start-on-weekday nil
 org-deadline-warning-days 14
 org-default-notes-file "~/org/notes.org"
 org-fast-tag-selection-single-key (quote expert)
 org-remember-store-without-hprompt t
 org-reverse-note-order t
)
(setq org-completion-use-ido t)
