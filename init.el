(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(add-to-list 'load-path "~/.emacs.d/ergoemacs-keybindings-5.3.4")
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

(defun monday? (time)
  "(monday? (current-time))"
  (= 1 (nth 6 (decode-time time))))

;; NOTE: source :name without :type will inherit from recipe with same name
(setq 
 el-get-sources
 '((:name el-get
	  :after (progn ()
			(if (monday? (current-time))
			    (progn
			      (el-get-emacswiki-refresh el-get-recipe-path-emacswiki)
			      (el-get-elpa-build-local-recipes)))))
   (:name ibuffer
          :type builtin)
   (:name yasnippet
          :before (progn
                    (setq yas/snippet-dirs "~/.emacs.d/snippets"))
          :after (progn
                   (yas-global-mode t)
                   (yas/load-directory "~/.emacs.d/snippets")))
   (:name autopair
          :after (progn ()
                       (autopair-global-mode 1)))
   (:name haml-mode
          :after (progn ()
                       (setq haml-indent-offset 2)))
   (:name emacs-w3m
          :after (progn ()
                        (setq browse-url-browser-function 'w3m-browse-url)))
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
   (:name rspec-mode
          :type github
          :pkgname "teaforthecat/rspec-mode"
          :after(progn
                  (setq rspec-use-rvm t)
                  (setq rspec-use-bundler-when-possible nil)
                  (setq rspec-use-rake-flag nil)))

   (:name  coffee-mode
          :after (progn
                   (add-to-list 'auto-mode-alist '("\\.coffee" . coffee-mode))
                   (add-to-list 'auto-mode-alist '("\\.coffee\\.erb" . coffee-mode))))
   (:name uniquify
          :type builtin
          :features (uniquify)
          :after (progn ()
                  (setq uniquify-buffer-name-style 'forward)))
   ))

;; future recipe: http://gitorious.org/emacs-rails/emacs-rails/blobs/master/rails-speedbar-feature.el

(setq recipes
      '(anything
		 browse-kill-ring
         cl-lib clojure-mode color-theme color-theme-ubuntu2
		 dired+ django-mode
		 emacs-w3m
		 fullscreen feature-mode
		 haml-mode htmlize
		 ioccur
		 js2-mode js-comint json-mode
		 list-register
		 magit
         nrepl
		 org org-publish org-redmine
		 pianobar private puppet-mode python pylookup
		 redo+ rinari rspec-mode ruby-end
         ;ruby-electric conficts with pair
         rvm
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

(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "dv")
(require 'ergoemacs-mode)
(ergoemacs-mode 1)


(require 'my-keybindings)
(require 'my-settings)


