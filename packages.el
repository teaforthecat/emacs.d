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
 '(
   (:name ediff
          :type builtin
          :after (progn ()
                        (setq ediff-diff-options "-w")
                        (setq ediff-split-window-function 'split-window-horizontally)
                        (setq ediff-window-setup-function 'ediff-setup-windows-plain)))
   (:name ibuffer
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
   (:name uniquify
          :type builtin
          :features (uniquify)
          :after (progn ()
                        (setq uniquify-buffer-name-style 'forward)))


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
      '(anything
        browse-kill-ring
        cl-lib clojure-mode color-theme color-theme-ubuntu2
        dash dired+ django-mode dbgr
        el-get emacs-w3m emacs-test-simple
        fullscreen feature-mode 
        haml-mode htmlize
        ioccur
        js2-mode js-comint json-mode
        list-register
        magit
        nrepl
        org org-publish org-redmine
        pianobar private puppet-mode python pylookup
        redo+ rinari rhtml-mode rspec-mode ruby-end
                                        ;ruby-electric conficts with pair
        rvm
        smooth-scrolling
        wanderlust
        yaml-mode))

(setq recipes
      (append
       recipes
       (loop for src in el-get-sources
	     collect (el-get-source-name src))))

(unless (string-match "apple-darwin" system-configuration)
  ;;doesn't compile on mac
  (add-to-list 'recipes 'emacs-jabber))

(el-get 'sync recipes)