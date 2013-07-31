
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/") ))

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
                              (if (eq system-type 'darwin)
                                  "/usr/local/bin/ispell"
                                "/usr/bin/ispell"))))
   (:name ruby-mode
          :type builtin
          :after (progn ()
                   (add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("gemspec" . ruby-mode))
                   (add-to-list 'auto-mode-alist '("json_builder" . ruby-mode))
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
        jabber js2-mode js-comint json-mode jump-char
        key-chord
        list-register
        magit markdown-mode multiple-cursors
        nrepl
        org org-publish
        paredit pianobar  puppet-mode python pylookup
        rainbow-delimiters redo+ rinari rhtml-mode rspec-mode ruby-end
                                        ;ruby-electric conficts with pair
        rails rails-speedbar-feature robe rvm
        s sass-mode smooth-scrolling smex sr-speedbar;; shell-command
        undo-tree
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
(if (eq system-type 'darwin)
    (progn ()
           (setq pianobar-program-command "/usr/local/bin/pianobar")
           ;; not sure why this path doesn't find pianobar
           (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))))

;; do-it
(el-get 'sync recipes)
