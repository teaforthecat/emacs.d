;; NOTE: source :name without :type will inherit from recipe with same name

;; bultins to trigger init file loading
(setq ct/builtin-pkgs (map 'list (lambda(p) (list :name p :type 'builtin))
                            '(align
                              comint
                              diary-lib
                              dired+
                              ediff
                              erc
                              ffap
                              ;;flyspell
                              ibuffer
                              ido
                              ;;org-mobile
                              ;; org-mode ;; try using own recipe
                              ruby-mode
                              ;;python
                              tramp
                              shell
                              smtpmail)))


(setq el-get-sources (append ct/builtin-pkgs
                             '(;(:name el-get)
                               (:name uniquify
                                      :type builtin
                                      :features (uniquify)
                                      :after (progn ()
                                                    (setq uniquify-buffer-name-style 'forward)))
                               ;; non-builtin
                               ;; (:name autopair ;;being replaced by spartparens
                               ;;        :after (progn ()
                               ;;                      (autopair-global-mode 1)))
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
                               (:name yasnippet
                                      :before (progn
                                                (setq yas/snippet-dirs "~/.emacs.d/snippets"))
                                      :after (progn
                                               (yas-global-mode t)
                                               (yas/load-directory "~/.emacs.d/snippets"))))))

(setq recipes
      '(ace-jump-mode ack-and-a-half
        bookmark+
        clojure-mode color-theme
        dash dictionary diminish dired-details+ ;django-mode
        el-get eproject expand-region exec-path-from-shell emacs-w3m ;;emacs-w3m needs to come before wanderlust
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
        org-mode org-publish ;; org-dotemacs
        paredit pianobar popwin  puppet-mode ;;pylookup ;;powerline seems cool buggy though
        rainbow-delimiters revive;;redo+
        request rinari rhtml-mode rspec-mode ruby-end ruby-hash-syntax;rainbow-mode for colors
                                        ;ruby-electric conficts with pair
;;        rails rails-speedbar-feature  rvm ;; robe
        s sass-mode smartparens smooth-scrolling smex sr-speedbar;; shell-command
        undo-tree
;        visual-regexp-steroids
        wanderlust web-mode
        yaml-mode
        zencoding-mode))

;; el-get-sources contains package definitions that can be "synced" by el-get
;; we need a list of names to provide to the sync function to do it
;; here we are treating them as one and the same
(setq recipes
      (append
       recipes
       (loop for src in el-get-sources
             collect (el-get-source-name src))))

(provide 'recipes)
