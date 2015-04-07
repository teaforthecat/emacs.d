(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;;use-package 2.0 style
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(eval-and-compile (push "~/.emacs.d/lisp" load-path))
(push "/usr/local/bin" exec-path)

(require 'reset)
(require 'navigator)
(require 'my-functions)
(require 'contrib-functions)
(require 'settings)



(defalias 'pro 'ct/goto-project)
(defalias 'tl 'toggle-truncate-lines)
(defalias 'tc 'tramp-cleanup-all-connections)
(defalias 'tb 'tramp-cleanup-all-buffers)
(defalias 'cds (lambdo (ct/cdsudo "sudo" "/etc" )))

(use-package fullframe
  :config
  (fullframe ibuffer ibuffer-quit))

(use-package sparkline) ;; why? because it is cool
(use-package subr-x) ;;hash-table and string functions

(bind-key "M-#" (lambdo (jump-to-register :temporary-fullscreen))) ;;works with advice around delete other windows

;; consider making this buffer local to only fire on emacs-lisp-mode
(add-hook 'after-save-hook 'byte-compile-current-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; init-elisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()(progn
                                           (eldoc-mode)
                                           (smartparens-strict-mode 1)
                                           (rainbow-delimiters-mode 1))))


(use-package rainbow-delimiters)
(use-package spaces
  :bind ("H-s" . sp-switch-space))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-global-mode))

(use-package yaml-mode)
(use-package flx-ido)

(use-package jabber
  :init
  (setq jabber-history-enabled t)
  (setq jabber-history-dir "~/.emacs.d/tmp/jabber-history")
  (setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
;   (setq jabber-muc-autojoin '("devops@im.office.gdi"))

  (defadvice jabber-connect (around insecure activate)
    (let ((starttls-extra-arguments '("--insecure" "--no-ca-verification")))
      ad-do-it))

  (defun no-presence-message (who oldstatus newstatus statustext)  nil  )
  (defun no-info-message (infotype buffer)  nil  )
  (setq jabber-roster-show-bindings nil)
  (setq jabber-alert-presence-message-function 'no-presence-message )
  (setq jabber-alert-info-message-function 'no-info-message )
  (setq jabber-roster-show-bindings nil)

  :defer 10)

(use-package browse-kill-ring+
  :defer 10
  :commands browse-kill-ring)

(use-package puppet-mode)

(use-package bookmark
  :config
  (use-package bookmark+))

(use-package dired
  :init
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (add-hook 'dired-mode-hook 'dired-omit-mode)
  (setq dired-listing-switches "-thal")
  (setq dired-details-hidden-string "  ")
  :config
  (bind-key "k"   'dired-kill-subdir dired-mode-map)
  (bind-key "TAB" 'dired-hide-subdir dired-mode-map)
  (bind-key "e"   'dired-up-directory dired-mode-map)
  (bind-key "o"   'dired-display-file dired-mode-map)
  (defadvice dired-kill-subdir (after kill-dired-buffer-as-well
                                    last (&optional REMEMBER-MARKS) activate protect)
  (if (= (point-min) (point))
      (kill-buffer)))
  (use-package dired-x)
  (use-package dired+))

(use-package request)
(use-package memoize)


(use-package ediff
  :init
  (setq ediff-diff-options "-w")
  (setq ediff-split-window-function 'split-window-horizontally)
  :config
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

(use-package restclient)

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
    (flx-ido-mode 1)))

(use-package nyan-mode
  :config (nyan-mode))

(use-package zenburn-theme)

(use-package guide-key
  :init
  (setq guide-key/guide-key-sequence '("M-s" "C-x 8" "M-o" "C-x r"))
  (setq guide-key/recursive-key-sequence-flag t)
  ;; (guide-key/key-chord-hack-on) ;; TODO: try this by adding "<key-chord>"
  :diminish guide-key-mode
  :config (guide-key-mode 1))

(use-package ace-window
  :init
  (setq aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  (setq aw-scope 'frame)
  :bind* ("C-t" . ace-window)
  :config
  (ace-window-display-mode))

(use-package idomenu
  :bind* ("M-s i" . idomenu))

(use-package undo-tree)

(use-package magit
  :bind* ("C-x g" . magit-status)
  :init
  (setq magit-last-seen-setup-instructions "1.4.0")
  :config

  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defun magit-quit-session ()
    "Restores the previous window configuration and kills the magit buffer"
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen))

  ;; whitespace toggle
  (defun magit-toggle-whitespace ()
    (interactive)
    (if (member "-w" magit-diff-options)
        (magit-dont-ignore-whitespace)
      (magit-ignore-whitespace)))

  (defun magit-ignore-whitespace ()
    (interactive)
    (add-to-list 'magit-diff-options "-w")
    (magit-refresh))

  (defun magit-dont-ignore-whitespace ()
    (interactive)
    (setq magit-diff-options (remove "-w" magit-diff-options))
    (magit-refresh))


  (eval-after-load 'magit
    '(progn
       (define-key magit-mode-map (kbd "M-3") 'delete-other-windows)
       (define-key magit-mode-map (kbd "q") 'magit-quit-session)
       (define-key magit-mode-map (kbd "W") 'magit-toggle-whitespace)

       (magit-key-mode-insert-action
        'logging "p" "Paths" 'ofv-magit-log-for-paths)))

  (defun ofv-magit-log-for-paths ()
    (interactive)
    (let* ((paths (read-string "Files or directories: "))
           (magit-custom-options paths))
      (magit-log)))

  )

(use-package ace-jump-mode
  ;; :bind*
  ;; ("C-." . ace-jump-mode)
  ;;("M-s s" . ace-jump-mode)
  ;;("C-," . ace-jump-mode-pop-mark)
  ;;:config (ace-jump-mode-enable-mark-sync); TODO: what does this do?

  )


(use-package color-moccur
  :commands (isearch-moccur isearch-all)
  :bind (("M-s o" . moccur)
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


(use-package recentf
  :config
  (recentf-mode 1))

(switch-to-buffer "*Messages*") ;; shows loading errors


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "/Users/cthompson/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "9cb6358979981949d1ae9da907a5d38fb6cde1776e8956a1db150925f2dad6c1" "4dd1b115bc46c0f998e4526a3b546985ebd35685de09bc4c84297971c822750e" default)))
 '(jabber-activity-mode nil)
 '(org-agenda-files
   (quote
    ("~/projects/gitlab/configuration/gathor/organizer.org" "~/projects/puppet/organizer.org" "~/projects/gitlab/development/csm/organizer.org" "~/projects/gitlab/configuration/morrell/organizer.org")))
 '(pallet-mode t)
 '(safe-local-variable-values
   (quote
    ((rspec-use-rake-when-possible)
     (rspec-use-bundler-when-possible)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(clojure-test-success-face ((t (:foreground "green" :underline t :weight bold))) t)
;;  '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
;;  '(idle-highlight ((t (:inherit region :box (:line-width -1 :color "grey75" :style released-button)))))
;;  '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))))
;;  '(magit-diff-add ((t (:foreground "chartreuse"))))
;;  '(magit-diff-del ((t (:foreground "red1"))))
;;  '(magit-diff-file-header ((t (:inherit diff-file-header :foreground "black"))))
;;  '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :foreground "black"))))
;;  '(magit-item-highlight ((t nil)))
;;  '(window-numbering-face ((t (:background "grey" :foreground "black"))) t))



;; to silence warnings when byte compiling
;; some functions won't be defined until the library is loaded
;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End:
