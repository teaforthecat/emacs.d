;;neccessary first, needs not to run
;;(eval-after-load "pymacs"
;;(progn
;;(add-to-list 'pymacs-load-path "~/.emacs.d/el-get/pymacs")
;;(pymacs-load "ropemacs")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib/slime")
;;(add-to-list 'load-path "~/.emacs.d/swank")


(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))


(add-to-list 'load-path "~/.emacs.d/contrib")
;;(require 'el-get)
;;(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(setq my-packages
      (append
       ;;'(slime)
       
       '(package)
       '(org-mode);;!!!!
       '(el-get color-theme ioccur autopair yasnippet auto-complete)
       '(calfw)
                '(magit htmlize)
                '(mwe-log-commands)
                '(emacs-w3m)
                '(js2-mode js-comint json)
                '(haml-mode yaml-mode )
                '(python pylookup)
                ;; '(edit-server)
                '(django-mode weblogger-el)))


(setq my-emwiki-packages 
      (append 
       '(fullscreen redo+ browse-kill-ring xml-rpc)       
      
       '(session)
;;       '(list-registers)
       ))

(el-get 'sync my-packages my-emwiki-packages)

;;package is available after el-get(?)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))

;; (setq inferior-lisp-program "/usr/bin/sbcl")
;; (require 'slime)
;; (slime-setup)

;; recipe fixes
;; (require 'ob-python)
(require 'fullscreen)
;;;(require 'django-html-mode)
;; emacs' own packages
(require 'uniquify)
(require 'diary-lib)
(require 'dictionary)
(require 'org-install) ;;provided by el-get
(require 'python)
(require 'flymake)
(require 'dired-x)
(require 'ansi-color)
(require 'org-protocol)

(add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
(add-to-list 'load-path "~/.emacs.d")
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "dv")
(require 'ergoemacs-mode)
(ergoemacs-mode 1)

;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )



(require 'my-functions)
(require 'init_python)
(require 'contrib-functions)
(require 'my-wl-settings)
;;(require 'my-alt-wl-settings)
(require 'my-org-settings)
(require 'my-cal-settings)
(require 'my-keybindings)
(require 'my-settings)
;;(require 'weblogger-setup)
(require 'my-macros)
(require 'rcodetools)





;;everything has been defined (post setup setup)
;; (google-calendar-download)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dictionary-default-dictionary "wn")
 '(dictionary-server "dictionary.bishopston.net")
 '(haml-indent-offset 4)
 '(list-command-history-max 60)
 '(max-lisp-eval-depth 1200)
 '(max-specpdl-size 3000)
 '(muse-blosxom-base-directory "~/proj/wiki/blog/")
 '(muse-colors-autogen-headings (quote outline))
 '(muse-colors-inline-image-method (quote muse-colors-use-publishing-directory))
 '(muse-completing-read-function (quote ido-completing-read))
 '(muse-html-charset-default "utf-8")
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-footer "~/personal-site/muse/generic-footer.html")
 '(muse-html-header "~/personal-site/muse/generic-header.html")
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"/common.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"screen\" href=\"/screen.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"print\" href=\"/print.css\" />")
 '(muse-latex-header "~/muse/latex-header.tex")
 '(muse-latexcjk-footer "
\\end{CJK*}
\\end{document}
")
 '(muse-mode-hook (quote (flyspell-mode footnote-mode)))
 '(muse-publish-comments-p t)
 '(muse-publish-date-format "%b. %e, %Y")
 '(muse-publish-desc-transforms (quote (muse-wiki-publish-pretty-title muse-wiki-publish-pretty-interwiki muse-publish-strip-URL)))
 '(muse-wiki-publish-small-title-words (quote ("the" "and" "at" "on" "of" "for" "in" "an" "a" "page")))
 '(muse-xhtml-footer "~/personal-site/muse/generic-footer.html")
 '(muse-xhtml-header "~/personal-site/muse/generic-header.html")
 '(muse-xhtml-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"/common.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"screen\" href=\"/screen.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"print\" href=\"/print.css\" />")
 '(python-guess-indent nil)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(weblogger-save-password t)
 '(weblogger-server-password "^emacs$")
 '(weblogger-server-url "http://wordpress.spysoundlab.com/xmlrpc.php"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hi-blue-b ((((min-colors 88)) (:foreground "#46657B"))))
 '(magit-diff-add ((t (:inherit diff-added :background "black" :foreground "#98fecc"))))
 '(magit-diff-del ((t (:inherit diff-removed :background "black" :foreground "orange"))))
 '(magit-diff-file-header ((t (:inherit diff-file-header :background "black" :foreground "grey" :underline nil :slant italic))))
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :background "black" :foreground "grey" :underline "grey" :slant italic))))
 '(muse-bad-link ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))))
 '(speck-mouse ((t (:background "black" :foreground "dark orange"))))
 '(speck-query ((t (:background "black" :foreground "dark orange")))))




(load-file "~/.emacs.d/el-get/bbdb/lisp/bbdb-hooks.el")

