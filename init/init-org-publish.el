(defun org-publish-to-stewart ()
  (start-process-shell-command "push-rsync" 'nil 
                               "rsync" 
                 "-tvzrL" "~/org/public_html/stewart/"
                 "cthompson@stewart:public_html") )

(setq org-publish-use-timestamps-flag 'nil)

(setq org-publish-project-alist
      '(
        ("stewart-static"
         :base-directory "~/org/stewart"
         :publishing-directory "~/org/public_html/stewart"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-function org-publish-attachment
         :completion-function org-publish-to-stewart)
        ("stewart-html"
         :base-directory "~/org/stewart"
         :base-extension "org"
         :publishing-directory "~/org/public_html/stewart"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :completion-function org-publish-to-stewart)
        ("stewart" :components ("stewart-html" "stewart-static"))

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
