;;(require 'package)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
;; (add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
(add-to-list 'load-path "~/.emacs.d")
(require 'reset)
(setq apple (eq system-type 'darwin))
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/") ))
(set-face-attribute 'default nil
                :family "Inconsolata" :height 165 :weight 'normal)


(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)
    (el-get-emacswiki-refresh el-get-recipe-path-emacswiki)
    (el-get-elpa-build-local-recipes)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(setq el-get-user-package-directory "~/.emacs.d/init")

;; NOTE: source :name without :type will inherit from recipe with same name
(setq
 el-get-sources
 '((:name el-get)

   ;; bultins
   (:name ediff
          :type builtin
          :after (progn ()
                        (setq ediff-diff-options "-w")
                        (setq ediff-split-window-function 'split-window-horizontally)
                        (setq ediff-window-setup-function 'ediff-setup-windows-plain)))

   (:name ibuffer
          :type builtin)
   (:name org-mobile
          :type builtin)
   (:name org-mode
          :type builtin)
   (:name ido
          :type builtin)
   (:name tramp
          :type builtin)
   (:name dired+
          :type builtin)
   (:name shell
          :type builtin)
   (:name diary-lib
          :type builtin)
   (:name uniquify
          :type builtin
          :features (uniquify)
          :after (progn ()
                        (setq uniquify-buffer-name-style 'forward)))
   (:name flyspell
          :type builtin
          :after (progn ()
                        (setq ispell-program-name
                              (if (string-match "apple-darwin" system-configuration)
                                  "/usr/local/bin/ispell"
                                "/usr/bin/ispell"))))
   (:name ruby-mode
          :type builtin
          :after (progn ()
                   (add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
                   (add-hook 'ruby-mode-hook
                             (lambda ()
                               (rvm-activate-corresponding-ruby)
                               (ruby-end-mode)
                               (flyspell-prog-mode)
                               (flyspell-mode 0)))))

   ;; non-builtin
   (:name autopair
          :after (progn ()
                        (autopair-global-mode 1)))
   (:name browse-kill-ring
          :after (progn ()
                        (setq browse-kill-ring-quit-action 'save-and-restore)))
   (:name  coffee-mode
           :after (progn
                    (add-to-list 'auto-mode-alist '("\\.coffee" . coffee-mode))
                    (add-to-list 'auto-mode-alist '("\\.coffee\\.erb" . coffee-mode))
                    (add-hook 'coffee-mode-hook 'set-tab-width-two)))
   (:name emacs-w3m
          :after (progn ()
                        (setq browse-url-browser-function 'w3m-browse-url)))
   (:name rspec-mode
          :type github
          :pkgname "teaforthecat/rspec-mode"
          :after (progn
                   (setq rspec-use-rvm t)
                   (setq rspec-use-opts-file-when-available nil)
                   (setq rspec-use-bundler-when-possible nil)
                   (setq rspec-use-rake-flag nil)
                   (add-hook 'rinari-minor-mode-hook 'rspec-verifiable-mode)
                   (add-hook 'after-save-hook (lambda ()
                                                (if (rspec-buffer-is-spec-p)
                                                    (rspec-verify-single))))
                   ))

   (:name yasnippet
          :before (progn
                    (setq yas/snippet-dirs "~/.emacs.d/snippets"))
          :after (progn
                   (yas-global-mode t)
                   (yas/load-directory "~/.emacs.d/snippets")))

   ))

(setq recipes
      '( ace-jump-mode
        cl-lib clojure-mode color-theme
        dash dictionary dired-details+ django-mode
        el-get emacs-w3m eproject expand-region exec-path-from-shell
        feature-mode find-things-fast find-file-in-repository
        flymake-python-pyflakes flymake-ruby 
        fullscreen
        goto-last-change
        haml-mode helm htmlize
        ioccur
        jabber js2-mode js-comint json-mode
        key-chord
        list-register
        magit markdown-mode multiple-cursors
        nrepl
        org org-publish
        paredit pianobar  puppet-mode python pylookup
        rainbow-delimiters redo+ rinari rhtml-mode rspec-mode ruby-end
                                        ;ruby-electric conficts with pair
        rails rails-speedbar-feature robe rvm
        sass-mode smooth-scrolling smex ;; shell-command
        wanderlust
        yaml-mode
        zencoding-mode))


(setq recipes
      (append
       recipes
       (loop for src in el-get-sources
             collect (el-get-source-name src))))


;; fullscreen is a wiki package so it may not be available at initial startup
(unless (file-exists-p (el-get-recipe-filename 'fullscreen))
  ;; uses ns-fullscreen
  (progn ()
         (setq fullscreen-ready t)
         (add-to-list 'recipes 'fullscreen)))

;;#needs to be set before packages initialize
(if apple
    (progn ()
           (setq pianobar-program-command "/usr/local/bin/pianobar")
           ;; not sure why this path doesn't find pianobar
           (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))))


(el-get 'sync recipes)

(require 'contrib-functions)
(require 'my-functions)
(require 'my-macros)
(require 'my-keybindings)

; TEMPORARY:  to figure out vagrant compatibility across users
(setenv "VAGRANTUP" "true")



; move to custom settings
(add-hook 'write-contents-functions 'delete-trailing-whitespace)
(display-time)
(global-visual-line-mode t)
(flyspell-mode 0)
(setq visible-bell t)
(setq speedbar-show-unknown-files t)
(setq speedbar-frame-parameters '((minibuffer)
                                 (width . 60)
                                 (border-width . 0)
                                 (menu-bar-lines . 0)
                                 (tool-bar-lines . 0)
                                 (unsplittable . t)
                                 (left-fringe . 0)))

(setq ace-jump-mode-scope 'window)
(setq password-cache t)
(setq password-cache-expiry nil) ;;duration of process
(setq use-dialog-box nil)

;; (setq window-min-height  nil)    ;; 2 windows but breaks things
(setq window-min-width  100)      ;; 4 windows
;;(setq window-min-height 10)

;;(setq w3m-key-binding 'info)

;; PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
(setq bookmark-file "~/.emacs.d/private/bookmarks")


;; PATH=~/bin:/usr/local/bin:$PATH
(setq emacs-tags-table-list
           '("~/.emacs.d" ".emacs.d/el-get"))

;; ready
(server-mode t)
;; set
;; (add-hook 'after-init-hook '(lambda () (org-agenda-list)
;;                               (switch-to-buffer-other-window
;;                                (or (get-buffer "timelog.org")
;;                                    (get-buffer "*scratch*") ))))

;; not at govdelivery, yet...
;; (add-hook 'before-save-hook 'whitespace-cleanup)
; (remove-hook 'before-save-hook 'whitespace-cleanup)


;;
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/rails-minor-mode"))
;; (require 'rails)

;; Enabled minor modes: Auto-Composition Auto-Compression Auto-Encryption
;; Autopair Autopair-Global Blink-Cursor Column-Number Delete-Selection
;; Diff-Auto-Refine Display-Time Eproject File-Name-Shadow Font-Lock
;; Global-Auto-Revert Global-Font-Lock Global-Subword Global-Undo-Tree
;; Global-Visual-Line Ido-Everywhere Line-Number Mouse-Wheel Movement
;; Recentf Server Shell-Dirtrack Show-Paren Subword Tooltip
;; Transient-Mark Undo-Tree Visual-Line Winner Yas Yas-Global
(diminish 'yas-minor-mode "y")
(diminish 'global-visual-line-mode "|")
(diminish 'robe-mode "~")
(diminish 'rinari-minor-mode "`")
(diminish 'ruby-end-mode)
(diminish 'rails-minor-mode)
(diminish 'eldoc-mode)

(rename-modeline "ruby-mode" ruby-mode "R")

(flyspell-prog-mode)

(setq rails-tags-command "ctags -e --Ruby-kinds=cfmF -o %s -R %s") ;;all kinds, don't append
(setq rails-tags-dirs '(".")) ;;all


(add-hook 'after-init-hook
          (lambda ()
            (load-theme 'misterioso t)
            (switch-to-buffer-other-window (get-buffer "*scratch*"))
            (set-cursor-color "#ffff00")
            (org-agenda-list)
            (spawn-shell "*local*")
            (delete-other-windows)
            ;; (fullscreen) sucks on lion
            (if (yes-or-no-p "connect?")
                (progn
                  (wl)
                  (jabber-connect-all)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
 '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))))
 '(magit-diff-add ((t (:foreground "chartreuse"))))
 '(magit-diff-del ((t (:foreground "red1"))))
 '(magit-diff-file-header ((t (:inherit diff-file-header :foreground "black"))))
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :foreground "black"))))
 '(magit-item-highlight ((t nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(tab-always-indent (quote complete)))
