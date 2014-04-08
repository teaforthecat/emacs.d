(require 'org-wl) ;;need to look around
;(require 'org-confluence) ;;need to look around
;(require 'org-deck) ;;need to look around
(require 'ox-latex) ;; requires mactex full

(require 'org-git-link)
(require 'org-mime)
(setq org-mime-library 'semi)

(add-hook 'org-mode-hook 'auto-fill-mode)

;; (add-to-list 'org-latex-packages-alist '("" "listings"))
;; (add-to-list 'org-latex-packages-alist '("" "color"))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-time-clocksum-format
      `(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(setq org-tags-alist '(pd collections emacs))

(setq org-todo-keywords
       '((sequence "TODO(t)" "REFILE(r)" "SOMEDAY(s)" "|"
                   "DONE(d)" "CANCELED(c@)")))

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/Dropbox/org/todo.org" "Tasks")
         "* TODO %^{Brief Description}\n%?\n%a\nAdded: %U")
        ("l" "Todo with link" entry
         (file+headline "~/Dropbox/org/todo.org" "Tasks")
         "* TODO %^{Brief Description}\n%?\n%a\nAdded: %U")
        ("r" "Reference" entry
         (file+headline "~/Dropbox/org/reference.org" "Reference")
         "* TODO %^{Brief Description}\n%a\n%?Added: %U\n")
        ))

(setq org-agenda-include-diary t)
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




;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; (require 'org-import-icalendar)
;; (setq org-import-icalendar-filename "cal.org")
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (sqlite . t)
   ))

(setq org-babel-sh-command "bash -i")

;; prefix arg to org-open-at-point is broken
;; (setq org-file-apps '(".html" . emacs))
