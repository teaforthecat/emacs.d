;; NOTE: source :name without :type will inherit from recipe with same name
(setq
 el-get-sources
 '((:name el-get)

   ;; bultins to trigger init file loading
   (:name align
          :type builtin)
   (:name comint
          :type builtin)

   (:name ediff
          :type builtin
          :after (progn ()
                        (setq ediff-diff-options "-w")
                        (setq ediff-split-window-function 'split-window-horizontally)
                        (setq ediff-window-setup-function 'ediff-setup-windows-plain)))

   (:name erc
          :type builtin)
   (:name ibuffer
          :type builtin)
   (:name ido
          :type builtin)
   (:name org-mobile
          :type builtin)
   (:name org-mode
          :type builtin)
   (:name python
          :type builtin)
   (:name tramp
          :type builtin)
   (:name dired+
          :type builtin)
   (:name shell
          :type builtin)
   (:name smtpmail
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
                              (if (eq system-type 'darwin)
                                  "/usr/local/bin/ispell"
                                "/usr/bin/ispell"))))
   (:name ruby-mode
          :type builtin)

   ;; non-builtin
   (:name autopair
          :after (progn ()
                        (autopair-global-mode 1)))
   (:name browse-kill-ring
          :after (progn ()
                        (setq browse-kill-ring-quit-action 'save-and-restore)))
   (:name coffee-mode
           :after (progn
                    (add-to-list 'auto-mode-alist '("\\.coffee" . coffee-mode))
                    (add-to-list 'auto-mode-alist '("\\.coffee\\.erb" . coffee-mode))
                    (add-hook 'coffee-mode-hook 'set-tab-width-two)))

   (:name edit-server
          :features edit-server
          :after (progn () (edit-server-start))) ;; for pairing maybe: edit-server-host
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
                   (add-hook 'rspec-mode-hook 'rinari-minor-mode)
                   (add-hook 'rspec-mode-hook 'ruby-end-mode)
                   ;; (add-hook 'after-save-hook (lambda ()
                   ;;                              (if (rspec-buffer-is-spec-p)
                   ;;                                  (rspec-verify-single))))
                   ))

   (:name yasnippet
          :before (progn
                    (setq yas/snippet-dirs "~/.emacs.d/snippets"))
          :after (progn
                   (yas-global-mode t)
                   (yas/load-directory "~/.emacs.d/snippets")))

   ))

(setq recipes
      '( ace-jump-mode ack-and-a-half
         bookmark+
        clojure-mode color-theme
        dash dictionary dired-details+ ;django-mode
        el-get emacs-w3m eproject expand-region exec-path-from-shell
        feature-mode find-things-fast find-file-in-repository
        ;; flymake-python-pyflakes flymake-ruby
        fullscreen flx flx-ido
        goto-last-change guide-key
        haml-mode htmlize ;helm
        idomenu ioccur
        jabber js2-mode js-comint json json-mode jump-char
        key-chord
        list-register
        magit markdown-mode multiple-cursors
        nrepl
        org org-publish ;; org-dotemacs
        paredit pianobar popwin  puppet-mode pylookup ;;powerline seems cool buggy though
        rainbow-delimiters redo+ request rinari rhtml-mode rspec-mode ruby-end ruby-hash-syntax;rainbow-mode for colors
                                        ;ruby-electric conficts with pair
;;        rails rails-speedbar-feature  rvm ;; robe
        s sass-mode smooth-scrolling smex sr-speedbar;; shell-command
        undo-tree
;        visual-regexp-steroids
        wanderlust web-mode
        yaml-mode
        zencoding-mode))


(setq recipes
      (append
       recipes
       (loop for src in el-get-sources
             collect (el-get-source-name src))))

(provide 'recipes)
