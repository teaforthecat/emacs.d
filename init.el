(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'epa)
;;use-package 2.0 style
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(eval-and-compile (push "~/.emacs.d/lisp" load-path))

(require 'reset)
(require 'navigator)
(require 'contrib-functions)
(require 'my-functions)
(require 'settings)


;; search
(define-prefix-command 'ct/search-keymap)
(global-set-key (kbd "C-s") 'ct/search-keymap)
(bind-key "C-s s" 'isearch-forward)
(bind-key "C-s b" 'browse-kill-ring)

(use-package avy
  :config
  (bind-key "C-s l" 'avy-goto-line)
  (bind-key "C-s n" 'avy-goto-word-or-subword-1))


;;(push "/usr/local/bin" exec-path)
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-getenv "SQL_PATH")
  (exec-path-from-shell-getenv "DYLD_LIBRARY_PATH")
  ;; weird
  ;; (getenv "DYLD_LIBRARY_PATH")
  ;; (setenv "DYLD_LIBRARY_PATH" (exec-path-from-shell-getenv "DYLD_LIBRARY_PATH"))
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize) ))



(use-package epa
  :init
  ;; maybe there is a better way to set this up
  (if (file-exists-p "~/.gnupg/env")
      (progn
        (setenv "GPG_AGENT_INFO" (-last 'stringp (s-split "=" (s-chomp (first (s-split "\n" (f-read "~/.gnupg/env")))))))
        ;;not sure this is neccessary (setenv "GPG_TTY" (terminal-name))
        ))
  :config

  (setq epa-file-encrypt-to "teaforthecat@gmail.com")
  ; use gpg-agent intstead
  ;(setq epa-file-cache-passphrase-for-symmetric-encryption t)
  )

(use-package cider
  :config
  (bind-key "C-r"  'comint-history-isearch-backward-regexp shell-mode-map)
  (unbind-key "M-n" cider-repl-mode-map)
  (unbind-key "M-r" cider-repl-mode-map))

;; (use-package golden-ratio
;;   :config
;;   (setq golden-ratio-adjust-factor .8
;;     golden-ratio-wide-adjust-factor .5)
;;   (golden-ratio-mode 1))

(use-package haml-mode)
(use-package sass-mode)

(defalias 'pro 'ct/goto-project)
(defalias 'tl 'toggle-truncate-lines)
(defalias 'tc 'tramp-cleanup-all-connections)
(defalias 'tb 'tramp-cleanup-all-buffers)
(defalias 'cds (lambdo (ct/cdsudo "sudo" "/etc" )))
(defalias 'grp 'ct/goto-remote-previous)
(bind-key "C-x r C" 'ct/bookmark-shell-command)

(use-package fullframe
  :config
  (fullframe ibuffer ibuffer-quit)
  (fullframe magit-status magit-quit))

(add-hook 'after-init-hook '(lambda ()
                              (toggle-frame-maximized)
                              (condition-case nil
                                  (if (cdr (x-display-list)) ;;not the right function
                                      (progn
                                        (make-frame-on-display (car (cdr (x-display-list))))
                                        (other-frame);;focus needed?
                                        (toggle-frame-maximized)
                                        (other-frame))))))

(use-package sparkline) ;; why? because it is cool
(use-package subr-x) ;;hash-table and string functions

(use-package feature-mode )
(use-package cucumber-goto-step
  :config
  (setq cgs-step-search-path "features/step_definitions/*.rb"))

;; consider making this buffer local to only fire on emacs-lisp-mode
(add-hook 'after-save-hook 'byte-compile-current-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; init-elisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()(progn
                                           (eldoc-mode)
                                           (smartparens-strict-mode 1)
                                           (rainbow-delimiters-mode 1))))


(use-package prodigy
  :init
  (setq  prodigy-services ()))
(use-package rainbow-delimiters)
(use-package spaces
  :bind ("H-s" . sp-switch-space))

(use-package org
  :load-path "/Users/cthompson/.emacs.d/.cask/24.5.1/elpa/org-20150810"
  :pin manual
  :init
  :config
  (setq org-src-fontify-natively t)

   (org-babel-do-load-languages
     'org-babel-load-languages
     '((dot . t)))
  (bind-key "M-h" 'backward-char org-mode-map) ;; org-mark-element
  (bind-key "M-e" 'sp-backward-delete-char org-mode-map) ;; org-delete-sentence
  )

(use-package ox-reveal
  :load-path "/Users/cthompson/projects/github/org-reveal/")

(use-package projectile
             :diminish projectile-mode
             :config
             (setq projectile-ignored-project-function 'file-remote-p)
             (projectile-global-mode)

             (defadvice projectile-switch-project (before pre-project-switch-wc-save activate)
               (window-configuration-to-register :ct/pre-project-switch))

             (defun ct/goto-previous-project ()
               (interactive)
               (jump-to-register :ct/pre-project-switch))
             (defalias 'gpp 'ct/goto-previous-project)

             (setq projectile-switch-project-action 'projectile-dired)

             (add-hook 'projectile-switch-project-hook 'ct/setup-project)

             (defun ct/setup-project ()
               (delete-other-windows)
               (split-window-right)
               (other-window 1)
               (cond ((and (file-exists-p "organizer.org")
                           (save-excursion ;; and a todo exists
                             (find-file "organizer.org")
                             (goto-char (point-min))
                             (re-search-forward "\\** TODO" nil t)))
                      (progn (find-file "organizer.org")
                             (org-agenda-file-to-front)))
                     ((file-exists-p "README.md")
                      (find-file "README.md")))

               (other-window 1)
               (split-window-below)
               (other-window 1)
               ;; consider (set-window-dedicated-p (get-buffer-window (current-buffer)) t)
               (spawn-shell (format "*%s*" default-directory))))

(use-package projector
  :config
  (setq  alert-default-style 'notifier)
  (setq projector-ido-no-complete-space t))

 (use-package yasnippet
   :config
   (yas-global-mode))

(use-package yaml-mode)


(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))
(use-package jabber
  :init
  (setq jabber-never-anonymous t) ;;TODO create pull request
  (setq jabber-history-enabled t)
  (setq jabber-history-dir "~/.emacs.d/tmp/jabber-history")
  (setq jabber-roster-line-format " %c %-25n %u %-8s  %S")

  (defadvice jabber-connect (around insecure activate)
    (let ((starttls-extra-arguments '("--insecure" "--no-ca-verification")))
      ad-do-it))

  (add-hook 'jabber-alert-message-hooks 'jabber-message-display)
  (add-hook 'jabber-chat-mode (lambda () (toggle-truncate-lines -1)))
  (add-hook 'jabber-chat-mode 'flyspell-mode)
  ;; TODO: set modeline on message alert


  (defun no-presence-message (who oldstatus newstatus statustext)  nil  )
  (defun no-info-message (infotype buffer)  nil  )
  (setq jabber-roster-show-bindings nil)
  (setq jabber-alert-presence-message-function 'no-presence-message )
  (setq jabber-alert-info-message-function 'no-info-message )
  (setq jabber-roster-show-bindings nil)
  :defer 5)

(use-package synonyms
  ;; wget http://www.gutenberg.org/files/3202/files.zip -O- | bsdtar -xzf- ; mv files/mthesaur.txt ~/.emacs.d/var/mthesaur.txt
  :init
  (setq synonyms-file "~/.emacs.d/var/mthesaur.txt")
  (setq synonyms-cache-file "~/.emacs.d/var/mthesaur.txt.cache"))

(use-package browse-kill-ring
  :commands browse-kill-ring
  :config
  (bind-key "C-s b" 'browse-kill-ring)
  (bind-key "M-s b" 'browse-kill-ring))

(use-package puppet-mode)

(use-package bookmark
  :config
  (use-package bookmark+))

(use-package dired
  :init
;; no worky (add-hook 'dired-mode-hook (lambda () (sleep 1) (goto-char (point-min))) t t)
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (add-hook 'dired-mode-hook 'dired-omit-mode)
  (setq dired-listing-switches "-thal")
  (setq dired-details-hidden-string "  ")
  (setq dired-auto-revert-buffer t)
  :config
  (bind-key "k"   'dired-kill-subdir dired-mode-map)
  (bind-key "TAB" 'dired-hide-subdir dired-mode-map)
  (bind-key "e"   'dired-up-directory dired-mode-map)
  (bind-key "o"   'dired-display-file dired-mode-map)
  (unbind-key "M-T" dired-mode-map)
  (defadvice dired-kill-subdir (after kill-dired-buffer-as-well
                                    last (&optional REMEMBER-MARKS) activate protect)
  (if (= (point-min) (point))
      (kill-buffer)))
  (use-package dired-x)
  (use-package dired+
    :config
    (unbind-key "M-T" dired-mode-map)
    (unbind-key "M-c" dired-mode-map)))

(use-package request)
(use-package memoize)

(use-package eww
  :config
  (bind-key "C-s e" 'eww-list-bookmarks)
  (bind-key "M-s l" 'eww-list-bookmarks))

(use-package eww-lnum
  :config
  (bind-key "f" 'eww-lnum-follow eww-mode-map)
  (bind-key "F" 'eww-lnum-universal eww-mode-map))

(use-package ht)

;; cool
;; (use-package symon-mode
;;   :init
;;   (setq symon-sparkline-type 'boxed))

(use-package ediff
  :init
  (setq ediff-diff-options "-w")
  (setq ediff-split-window-function 'split-window-horizontally)
  :config

  ;; todo move to fullscreen
  (defadvice ediff-files (before ediff-on-fullscreen activate)
    (window-configuration-to-register :ediff-fullscreen))

  (defadvice ediff-revision (before ediff-on-fullscreen activate)
    (window-configuration-to-register :ediff-fullscreen))

  (defadvice ediff-buffers (before ediff-on-fullscreen activate)
    (window-configuration-to-register :ediff-fullscreen))

  (defadvice ediff-windows-wordwise (before ediff-on-fullscreen activate)
    (window-configuration-to-register :ediff-fullscreen))

  (defadvice ediff-quit (after ediff-off-fullscreen activate)
    (jump-to-register :ediff-fullscreen))


  ;; magit
  (defadvice magit-ediff (before ediff-on-fullscreen activate)
    (window-configuration-to-register :ediff-fullscreen))


  (defun ct/ediff-revision ()
    (interactive)
    (ediff-revision (buffer-file-name)))

  )


(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (bind-key "M-R" 'sp-forward-sexp  sp-keymap)
  (bind-key "M-G" 'sp-backward-sexp sp-keymap))

(use-package restclient
  :config
  ;(bind-key "C-c C-c" 'restclient-http-send-current restclient-mode-map)
  )

(use-package remote-hosts :load-path "lisp")
(use-package visit-vagrant :load-path "lisp")

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point 'guess)
  (setq ido-use-virtual-buffers t) ;remember previously opened files
  (setq ido-max-window-height 20)
  (setq ido-max-prospects 18)
  ;; vertical ido
  (setq ido-decorations (quote ("\n=> " " " "\n   " "\n   ..."
                                "[" "]" " [No match]" " [Matched]"
                                " [Not readable]" " [Too big]" " [Confirm]")))

  :config
  (ido-mode t)
  (ido-everywhere t)

  (defun ido-my-keys ()
    "because the keymap is built dynamically"
    (define-key ido-completion-map " " 'ido-next-match)
    )
  (add-hook 'ido-setup-hook 'ido-my-keys)

  (use-package flx-ido
    :config
    (setq ido-use-faces nil) ;;maybe...
    (flx-ido-mode 1)))

;(use-package zenburn-theme)
;; todo: checkout C-x r f (frameset-to-register REGISTER)
(use-package guide-key
  :init
  (setq guide-key/guide-key-sequence '("C-s" "M-s" "C-x 8" "M-o" "C-x r" "C-b"))
  (setq guide-key/recursive-key-sequence-flag t)
  ;; (guide-key/key-chord-hack-on) ;; TODO: try this by adding "<key-chord>"
  :diminish guide-key-mode
  :config (guide-key-mode 1))


;; maybe...
;; (use-package key-chord
;;   :config
;;   (key-chord-mode 1)
;;   (key-chord-define-global ",," 'ace-jump-mode))

;; smallest library in the world?
;; temporary fullscreen
(defadvice delete-other-windows (before temporary-fullscreen activate)
  (window-configuration-to-register :temporary-fullscreen))
;; delete-other-windows is C-x 1, so C-x Shift-1
(bind-key "C-x C-!" (lambdo (jump-to-register :temporary-fullscreen)))

(use-package ace-window
  :init
  (setq aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  (setq aw-scope 'frame)
  (setq aw-background nil)
  :bind* ("C-t" . ace-window)
  :config
  (ace-window-display-mode))

(use-package idomenu
  :bind*
  ("C-s i" . idomenu)
  ("M-s i" . idomenu))

(use-package undo-tree)

(use-package magit
  :config
  (add-hook 'magit-mode-hook (lambda () (setq show-trailing-whitespace t))) ;;wtf? .emacs.d/.cask/24.5.1/elpa/magit-20150713.2244/magit-mode.el:328 (setq show-trailing-whitespace nil)

  :bind* ("C-x g" . magit-status))

;; use avy instead
;; (use-package ace-jump-mode
;;   :bind
;;   ("M-s t" . ace-jump-mode))

(use-package color-moccur
  :commands (isearch-moccur isearch-all)
  :bind (
         ("C-s o" . moccur)
         ("C-s d" . dired-do-moccur)
         ("M-s o" . moccur) ;;use control instead
         ("M-s d" . dired-do-moccur))
  :init
  (bind-key "M-o" 'isearch-moccur isearch-mode-map)
  (bind-key "M-O" 'isearch-moccur-all isearch-mode-map)
  :config
  (use-package moccur-edit))


(use-package edit-server
  :if window-system
  :init
  (add-hook 'after-init-hook 'server-start t)
  (add-hook 'after-init-hook 'edit-server-start t))


(use-package markdown-mode
  :config
  (unbind-key "M-n" markdown-mode-map))

(use-package recentf
  :config
  (setq recentf-max-saved-items 100)
  (recentf-mode 1))

(use-package pianobar
  :config
  (defadvice pianobar-pause-song (around stay-home activate)
    "so I don't have to worry about starting pianobar while on a remote file"
    (let ((default-directory "~"))
      ad-do-it)))

(use-package php-mode)

 ;; (use-package php+-mode
 ;;    :config
 ;;    (php+-mode-setup))

(use-package clojure-mode
  :config
  ;; (setq lisp-indent-offset 2)
  ;; (setq clojure-defun-style-default-indent t)
  (define-clojure-indent
    (defroutes 'defun)
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (HEAD 2)
    (ANY 2)
    (context 2)))

(use-package clojure-cheatsheet)

(use-package shell

  :config
  ;(add-hook 'shell-mode-hook (lambda ()
  ;                             (add-hook 'kill-buffer-hook 'comint-write-input-ring nil t)))

;; m-p     comint-previous-input           Cycle backwards in input history
;; m-n     comint-next-input               Cycle forwards
;; m-r     comint-previous-matching-input  Previous input matching a regexp
  ;; m-s     comint-next-matching-input      Next input that matches
  (bind-key "C-r"  'comint-history-isearch-backward-regexp shell-mode-map)
  (bind-key "C-p"  'comint-previous-input shell-mode-map)
  (bind-key "C-n"  'comint-next-input shell-mode-map)
  (unbind-key "M-s" shell-mode-map)
  (unbind-key "M-r" shell-mode-map)
  (unbind-key "M-n" shell-mode-map))


(use-package tramp
  ;;for 'control path too long':  (put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))
  :init
;;  (setq tramp-ssh-controlmaster-options  " -o ControlPath=%t.%%r@%%h:%%p -o ControlMaster=auto -o ControlPersist=yes " )
  (setq tramp-ssh-controlmaster-options "") ;; does this make the connection use ssh_config then?
  )


(use-package ruby-mode
  :config
  (use-package inf-ruby
    :config
    (unbind-key "M-r" comint-mode-map)
    (unbind-key "C-r" comint-mode-map);; .....
    ))


(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(eval-after-load 'inf-ruby
      '(define-key inf-ruby-minor-mode-map
       (kbd "C-c C-s") 'inf-ruby-console-auto))

(use-package rspec-mode
  :config
  (setq rspec-use-rake-when-possible nil)
;;  (add-hook 'dired-mode-hook 'rspec-dired-mode)
)

(use-package rinari
  :config
  (add-hook 'ruby-mode-hook 'rinari-launch))

(use-package yari
  :init
  (define-key 'help-command (kbd "R") 'yari))

(eval-when-compile
  (defvar ag-mode-map)) ;;I'm not sure why this isn't set in ag.el

(use-package wgrep
  ;; C-c C-p edit
  ;; C-x C-s write
  ;; save-some-buffers
  )

(use-package wgrep-ag)

(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

;;(switch-to-buffer "*Messages*") ;; shows loading errors
(load-theme 'flatland)



;; to silence warnings when byte compiling
;; some functions won't be defined until the library is loaded
;; Local Variables:
;; byte-compile-warnings: (not unresolved free-variable)
;; End:
;; maybe this has to come later than reset.el
