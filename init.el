(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq required-recipes '(anything
                         auto-complete
                         browse-kill-ring
                         color-theme
                         dired+
                         org
                         list-register
                         redo+
                         yasnippet))

(setq optional-recipes '(autopair 
			 ioccur
             fullscreen
             magit
             emacs-w3m
             wanderlust

;error             pianobar
			 yaml-mode))

(setq js-recipes '(js2-mode js-comint json))
(setq python-recipes '(python pylookup django-mode
                              js-recipes))
;(setq rails-recipes '(js-recipes) rinari ruby-end rvm haml-mode coffee-mode )
(defun load-rails-recipes ()
  (let ((rails-development-packages (append optional-recipes
					    js-recipes
					    '(rinari ruby-end rvm haml-mode coffee-mode))))
  (if (consp rails-development-packages)
      (message "LIST"))
  (el-get 'sync rails-development-packages)))

(el-get 'sync required-recipes)
(el-get 'sync optional-recipes)
;(load-rails-recipes)

(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; recipe fixes
;; (require 'ob-python)
;;(require 'fullscreen)
;;;(require 'django-html-mode)
;; emacs' own packages
(require 'uniquify)
;;(require 'diary-lib)
;;;(require 'dictionary)
(require 'org-install) ;;provided by el-get
;(require 'python)
;(require 'flymake)
;(require 'dired-x)
;(require 'ansi-color)
;(require 'org-protocol)

(add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
(add-to-list 'load-path "~/.emacs.d")
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "dv")
(require 'ergoemacs-mode)
(ergoemacs-mode 1)

;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )



;(require 'my-functions)
;(require 'init_python)
(require 'contrib-functions)
;(require 'my-wl-settings)
;;(require 'my-alt-wl-settings)
;(require 'my-org-settings)
;(require 'my-cal-settings)
(require 'my-keybindings)
(require 'my-settings)
;;(require 'weblogger-setup)
;(require 'my-macros)
;(require 'rcodetools)

;;(add-hook 'after-init-hook (lambda (load-file "spawn-shells")))




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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))
