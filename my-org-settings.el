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



(setq org-agenda-files '("~/org"))
;;redundant?
(setq org-directory "~/org")

(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

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
(defun push-to-stewart ()
  (start-process-shell-command "push-rsync" 'nil 
                               "rsync" 
                 "-tvzrL" "~/org/public_html/stewart/"
                 "cthompson@stewart:public_html") )

;;(push-to-stewart)
;; html export
(require 'org-publish)
(setq org-publish-use-timestamps-flag 'nil)
(setq org-publish-project-alist
      '(
        ("stewart-static"
         :base-directory "~/org/stewart"
         :publishing-directory "~/org/public_html/stewart"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-function org-publish-attachment
         :completion-function push-to-stewart)
        ("stewart-html"
         :base-directory "~/org/stewart"
         :base-extension "org"
         :publishing-directory "~/org/public_html/stewart"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :completion-function push-to-stewart)
        ("stewart" :components ("stewart-html" "stewart-static"))

        ("colman"
         :base-directory "~/org/colman"
         :base-extension "org"
         :publishing-directory "~/org/public_html/colman"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :title "Colman Project"
         ;; :completion-function push-to-stewart
         )
        ("s5-presentation"
         :base-directory "~/org/s5-presentation"
         :base-extension "org"
         :publishing-directory "~//"
         )

        ))


(setq org-export-html-preamble 'nil)
(setq org-export-html-postamble 'nil)
;; html export styles
(setq org-export-html-style
  " <style type=\"text/css\">
    <![CDATA[

    ]]>
   </style>"
)
(setq org-export-html-style-include-default 'nil)
(setq org-export-html-style-extra 'nil)

(add-to-list 'load-path "~/.emacs.d/el-get/org-mode/EXPERIMENTAL/")
(require 'org-mediawiki)

;; #+HTML: Literal html
;; #+BEGIN_HTML
;;     All lines between these markers are exported literally
;;     #+END_HTML
;; #+ATTR_HTML: title="The Org mode homepage" style="color:red;"
;;     [[http://orgmode.org]]
;; #+CAPTION: This is a table with lines around and between cells
;; #+ATTR_HTML: border="2" rules="all" frame="border"
;;[[file:highres.jpg][file:thumb.jpg]]
;; #+BEGIN_EXAMPLE -t -w 40
;;   (defun org-xor (a b)
;;      "Exclusive or."
;;      (if a (not b) b))
;; #+END_EXAMPLE
;; org-export-html-style
;; org-export-html-style-extra
;; :HTML_CONTAINER_CLASS:
;; :CUSTOM_ID:
;; #+STYLE: <link rel="stylesheet" type="text/css" href="stylesheet.css" />
;; #+INFOJS_OPT: view:info toc:nil
(provide 'my-org-settings)
