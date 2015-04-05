(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
;;use-package 2.0 style
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(push "~/.emacs.d/lisp" load-path)
(require 'reset)
(require 'navigator)
(require 'my-functions)
(require 'contrib-functions)

(use-package request)
(use-package memoize)
(use-package smartparens)

(use-package remote-hosts :load-path "lisp")
(use-package visit-vagrant :load-path "lisp")

(use-package nyan-mode
  :config (nyan-mode))

(use-package zenburn-theme)

(use-package guide-key
  :init (setq guide-key/guide-key-sequence '("M-s"))
  :config (guide-key-mode 1))

(use-package undo-tree)
(use-package magit
  :init
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package moccur-edit)
(use-package color-moccur
  :commands (isearch-moccur isearch-all)
;  :bind ("C-c C-o" . moccur)
  :init
  (bind-key "M-o" 'isearch-moccur isearch-mode-map)
  (bind-key "M-O" 'isearch-moccur-all isearch-mode-map)
  :config
  (use-package moccur-edit)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "9cb6358979981949d1ae9da907a5d38fb6cde1776e8956a1db150925f2dad6c1" "4dd1b115bc46c0f998e4526a3b546985ebd35685de09bc4c84297971c822750e" default)))
 '(pallet-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
