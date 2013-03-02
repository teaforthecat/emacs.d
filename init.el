(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
;; (add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
(add-to-list 'load-path "~/.emacs.d")
(require 'minimals)

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


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
   (:name ediff
          :type builtin
          :after (progn ()
                        (setq ediff-diff-options "-w")
                        (setq ediff-split-window-function 'split-window-horizontally)
                        (setq ediff-window-setup-function 'ediff-setup-windows-plain)))
   (:name ibuffer
          :type builtin)
   (:name org-mobile :type builtin)
   (:name el-get 
	  :after (progn () nil) )
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
   (:name ediff
          :type builtin
          :after (progn ()
                        (setq ediff-diff-options "-w")
                        (setq ediff-split-window-function 'split-window-horizontally)
                        (setq ediff-window-setup-function 'ediff-setup-windows-plain)))
   (:name uniquify
          :type builtin
          :features (uniquify)
          :after (progn ()
                        (setq uniquify-buffer-name-style 'forward)))
   (:name flyspell
          :type builtin
          :after (progn ()
                        (flyspell-mode 1)
                        (flyspell-prog-mode)))
   (:name ruby
          :type builtin
          :after (progn
                   (add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))))

   (:name yasnippet
          :before (progn
                    (setq yas/snippet-dirs "~/.emacs.d/snippets"))
          :after (progn
                   (yas-global-mode t)
                   (yas/load-directory "~/.emacs.d/snippets")))
   (:name autopair
          :after (progn ()
                        (autopair-global-mode 1)))
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

   (:name  coffee-mode
           :after (progn
                    (add-to-list 'auto-mode-alist '("\\.coffee" . coffee-mode))
                    (add-to-list 'auto-mode-alist '("\\.coffee\\.erb" . coffee-mode))))
   (:name  undo-tree
           :after (progn
                    (setq undo-tree-mode-lighter "")
                    (global-undo-tree-mode)))

   ))

;; future recipe: http://gitorious.org/emacs-rails/emacs-rails/blobs/master/rails-speedbar-feature.el

(setq recipes
      '( ace-jump-mode
        browse-kill-ring
        cl-lib clojure-mode color-theme color-theme-ubuntu2
        dash dired+ django-mode
        el-get emacs-w3m eproject
        fullscreen feature-mode
        haml-mode htmlize
        ioccur
        js2-mode js-comint json-mode
        key-chord
        list-register
        magit markdown-mode
        nrepl
        org org-publish
        pianobar private puppet-mode python pylookup
        redo+ rinari rhtml-mode rspec-mode ruby-end
                                        ;ruby-electric conficts with pair
        rvm
        smooth-scrolling
        wanderlust
        yaml-mode
        zencoding-mode))


(setq recipes
      (append
       recipes
       (loop for src in el-get-sources
	     collect (el-get-source-name src))))

(unless (string-match "apple-darwin" system-configuration)
  ;;doesn't compile on mac
  (add-to-list 'recipes 'emacs-jabber))

(el-get 'sync recipes)

;; (setenv "ERGOEMACS_KEYBOARD_LAYOUT" "dv")
;; (require 'ergoemacs-mode)
;; (ergoemacs-mode 1)


(require 'contrib-functions)
(require 'my-functions)
(require 'my-keybindings)

;; from magnars
;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)
;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; Show keystrokes in progress
(setq echo-keystrokes 0.1)
;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)
;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)
;; Transparently open compressed files
(auto-compression-mode t)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)
;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

(show-paren-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Don't break lines for me, please
(setq-default truncate-lines t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)


;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

(when (eq system-type 'darwin) ;; homebrew
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (setq ns-function-modifier 'hyper))

(setq temporary-file-directory "~/.emacs.d/tmp/")

(add-hook 'after-init-hook '(lambda () (org-agenda-list)
                              (switch-to-buffer-other-window 
                               (or (get-buffer "timelog.org")
                                   (get-buffer "*scratch*") ))))

(add-hook 'write-contents-functions 'delete-trailing-whitespace)
(setq require-final-newline  t)  

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(server-mode t)
(color-theme-subtle-hacker)
(ns-toggle-fullscreen)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "dark Blue")))))
