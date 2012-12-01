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

;; NOTE: currently deciding which to use, remember or capture

(setq org-capture-templates '(("t" "Todo" entry
                               (file+headline "~/org/mygtd.org" "Tasks")
                               "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" :prepend t)
                              ("w" "WorkAgenda" entry
                               (file+headline "~/org/agendas/walker.org" "Walker")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("j" "Journal" entry
                               (file+headline "~/org/journal.org" "")
                               "\n %^{topic} %T \n%i%?\n" :prepend t)
                              ("e" "Email Todo" entry
                               (file+headline "~/org/mygtd.org" "Tasks")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)))

(setq org-agenda-files '("~/org/agendas/user-groups.org"
                         "~/org/agendas/walker.org"
                         "~/org/mygtd.org"))

(setq 
 org-agenda-span 30
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
