(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
(add-to-list 'load-path "~/.emacs.d")

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


(require 'el-get nil t)

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(setq el-get-user-package-directory el-get-recipe-path)

; NOTE: source def without :type will inherit from recipe with same name

;(unless (string-match "apple-darwin" system-configuration))

(defun monday? (time)
  "(monday? (current-time))"
  (= 1 (nth 6 (decode-time time))))

(setq 
 el-get-sources
 '(
   anything autopair auto-complete 
            browse-kill-ring
                       cl-lib color-theme 
                       dired+
                       emacs-jabber emacs-w3m
                       fullscreen feature-mode
                       htmlize
                       ioccur
                       js2-mode js-comint json
                       list-register
                       magit
                       org org-redmine
                       pianobar
                       python pylookup django-mode
                       redo+
                       rinari ruby-end rvm haml-mode coffee-mode
                       wanderlust
                       yaml-mode yasnippet                       
                       (:name uniquify
                              :type built-in)
                       (:name el-get
                              :after (lambda ()
                                       (if (monday? (current-time))
                                           (progn
                                             (el-get-self-update)
                                             (el-get-emacswiki-refresh el-get-recipe-path-emacswiki)
                                             (el-get-elpa-build-local-recipes)))))))



(el-get)
;; recipe fixes
;; (require 'ob-python)
;;(require 'fullscreen)
;;;(require 'django-html-mode)
;; emacs' own packages
;(require 'uniquify)
;;(require 'diary-lib)
;;;(require 'dictionary)
;(require 'python)
;(require 'flymake)
;(require 'dired-x)
;(require 'ansi-color)
;(require 'org-protocol)

(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "dv")
(require 'ergoemacs-mode)
(ergoemacs-mode 1)

;; tell jabber to hush
(defun no-presence-message (who oldstatus newstatus statustext)  nil  )
(defun no-info-message (infotype buffer)  nil  )

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

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
