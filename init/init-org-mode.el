(setq org-agenda-include-diary t)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-time-clocksum-format
      `(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(setq org-tags-alist '(pd collections emacs))

(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w@)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c@)")))

(setq org-capture-templates '(("t" "Todo" entry
                               (file+headline "~/org/refile.org" "Tasks")
                               "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" :prepend t)
                              ("w" "WorkAgenda" entry
                               (file+headline "~/org/agendas/walker.org" "Walker")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("e" "Emacs" entry
                               (file+headline "~/org/projects/emacs.org" "Tickler")
                               "* SOMEDAY %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("r" "Reference" entry
                               (file+headline "~/org/reference.org" "Reference")
                               "* TODO %^{Brief Description}\n%a\n%?Added: %U\n" :prepend t)
                              ("j" "Journal" entry
                               (file+headline "~/org/journal.org" "")
                               "\n %^{topic} %T \n%i%?\n" :prepend t)))

(setq org-agenda-diary-file "~/org/.diary")

(setq org-directory "~/org/")

;;weird that a file with a dir listed is required to load an entire directory
(setq org-agenda-files "~/org/agenda-files.txt" )

(setq 
 org-agenda-span 7
 org-agenda-show-all-dates nil
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-start-on-weekday nil
 org-deadline-warning-days 3
 org-default-notes-file "~/org/notes.org"
 ;not sure what this does org-fast-tag-selection-single-key (quote expert)
 org-completion-use-ido t
 org-log-into-drawer "LOG"
)




(org-babel-do-load-languages 'org-babel-load-languages
                             '((emacs-lisp . t) (dot . t)))
;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)
