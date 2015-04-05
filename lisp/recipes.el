;; el-get recipes to install and initialize
;; NOTE: source :name without :type will inherit from recipe with same name

;; register some bultins with el-get to trigger init-* file loading
(setq ct/builtin-pkgs (map 'list (lambda(p) (list :name p :type 'builtin))
                            '(align
                              comint
                              diary-lib
                              dired+
                              ediff
                              erc
                              ffap
                              ibuffer
                              ido
                              make-mode
                              ruby-mode
                              tramp
                              shell
                              smtpmail)))
(require 'ffap) ;; wtf
(require 'tramp) ;; wtf

(setq el-get-sources (append ct/builtin-pkgs
                             '((:name uniquify
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
                               (:name pianobar
                                      :before (progn ()
                                                     (if (eq system-type 'darwin)
                                                         (setq pianobar-program-command "/usr/local/bin/pianobar"))))

                               (:name rainbow-delimiters
                                      :after `(rainbow-delimiters-mode 1))
                               (:name yasnippet
                                      :before (progn
                                                (setq yas/snippet-dirs "~/.emacs.d/snippets"))
                                      :after (progn
                                               (yas-global-mode t)
                                               (yas/load-directory "~/.emacs.d/snippets"))))))

(setq recipes
      '(ace-jump-mode ace-window ack-and-a-half
        bookmark+
        clojure-mode cider ;color-theme 
        dash dash-at-point;dictionary
        diminish dired-details+ ;django-mode
        el-get ;;eproject
        expand-region exec-path-from-shell emacs-w3m ;;emacs-w3m needs to come before wanderlust
        feature-mode find-things-fast find-file-in-repository flatland-theme fullframe
        flycheck
        ;; flymake-python-pyflakes flymake-ruby
        fullscreen flx flx-ido
        goto-last-change guide-key
        haml-mode htmlize highlight-symbol;helm
        idomenu ioccur idle-highlight-mode ibuffer-vc
        jabber js2-mode js-comint json json-mode jump-char
        key-chord
        list-register
        magit markdown-mode memoize multiple-cursors mu4e
        org-mode org-publish ;; org-dotemacs
        paredit popwin ;;prodigy -installed with package
        projectile
        puppet-mode ;;pylookup ;;powerline seems cool buggy though
        queue
        revive;;redo+
        request restclient rinari rhtml-mode rspec-mode  ruby-hash-syntax;rainbow-mode for colors
                                        ;ruby-electric conficts with pair
        ;;        rails rails-speedbar-feature  rvm ;;
        robe
        rbenv
        s
 sass-mode smartparens smooth-scrolling
        ;;smex something about execute-extended-command
        ;;sr-speedbar;; shell-command
        smartscan
        undo-tree bind-key use-package
;        visual-regexp-steroids
        wanderlust web-mode workgroups2
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
