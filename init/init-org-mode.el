(setq org-agenda-include-diary t)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-time-clocksum-format
      `(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(setq org-tags-alist '(pd collections emacs))

(setq org-todo-keywords
       '((sequence "TODO(t)" "REFILE(r)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c@)")))

(setq org-capture-templates '(("t" "Todo" entry
                               (file+headline "~/Dropbox/org/refile.org" "Tasks")
                               "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" :prepend t)
                              ("w" "WorkAgenda" entry
                               (file+headline "~/Dropbox/org/agendas/walker.org" "Walker")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("e" "Emacs" entry
                               (file+headline "~/Dropbox/org/projects/emacs.org" "Tickler")
                               "* SOMEDAY %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("r" "Reference" entry
                               (file+headline "reference.org" "Reference")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("j" "Journal" entry
                               (file+headline "~/Dropbox/org/journal.org" "Quick Thoughts")
                               "* REFILE %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ))

(setq org-agenda-diary-file "~/Dropbox/org/.diary")

(setq org-directory "~/Dropbox/org/")

;;weird that a file with a dir listed is required to load an entire directory
(setq org-agenda-files "~/Dropbox/org/agenda-files.txt" )

(setq 
 org-agenda-span 7
 org-agenda-show-all-dates nil
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-start-on-weekday nil
 org-deadline-warning-days 3
 org-default-notes-file "~/Dropbox/org/notes.org"
 ;not sure what this does org-fast-tag-selection-single-key (quote expert)
 org-completion-use-ido t
 org-log-into-drawer "LOG"
)




(org-babel-do-load-languages 'org-babel-load-languages
                             '((emacs-lisp . t) (dot . t)))
;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; (require 'org-import-icalendar)
;; (setq org-import-icalendar-filename "cal.org")
