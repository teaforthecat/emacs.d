(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(add-to-list 'load-path "~/.emacs.d")
(require 'reset)

;; (setq debug-on-error nil)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/") ))

;; install el-get if not present
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)
    (el-get-emacswiki-refresh el-get-recipe-path-emacswiki)
    (el-get-elpa-build-local-recipes)))

(add-to-list 'el-get-recipe-path    "~/.emacs.d/recipes")
(setq el-get-user-package-directory "~/.emacs.d/init")


;; TODO: fullscreen might not be neccessary anymore:
;; fullscreen is a wiki package so it may not be available at initial startup
(unless (file-exists-p (el-get-recipe-filename 'fullscreen))
  ;; uses ns-fullscreen
  (progn ()
         (setq fullscreen-ready t)
         (add-to-list 'recipes 'fullscreen)))

;; load private variables
(dolist (f (directory-files "~/.emacs.d/private" t ".el$"))
  (load-file f))


;; Mail
;; uses ~/.authinfo
(setq
 smtpmail-starttls-credentials '(("smtp.gmail.com" "587" nil nil))
 smtpmail-auth-credentials  (expand-file-name "~/.authinfo")
 smtpmail-default-smtp-server "smtp.gmail.com")


;; needs to be set before packages initialize
(if (eq system-type 'darwin)
    (progn ()
           (setq pianobar-program-command "/usr/local/bin/pianobar")
           ;; not sure why this path doesn't find pianobar
           (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))))
(setenv "LC_ALL" "en_US.UTF-8")


(require 'recipes)
(el-get 'sync recipes) ;;load everything


(require 'contrib-functions)
(require 'my-functions)
(require 'my-macros)
(require 'my-keybindings)


;; thanks
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(add-hook 'after-save-hook 'byte-compile-current-buffer)

(org-babel-load-file "~/.emacs.d/organizer.org")

; TODO: move to custom settings file
(set-face-attribute 'default nil
                :family "Inconsolata" :height 165 :weight 'normal)

;; fullscreen with font height 165
(setq initial-frame-alist
      (list (cons 'width
                  (round (/ (x-display-pixel-width) 9.114)))
            (cons 'height
                  (round (/ (x-display-pixel-height) 18)))))


(add-hook 'write-contents-functions 'whitespace-cleanup)

(display-time)

(setq ffip-find-options "-not -regex \".*svn.*\" -not -path '*/.bundle/*' -not -path '*/contrib/*'")

;; (setq truncate-lines nil)
(setq visible-bell t)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
(setq tab-always-indent 'complete)
(setq speedbar-show-unknown-files t)
(setq speedbar-frame-parameters '((minibuffer)
                                 (width . 60)
                                 (border-width . 0)
                                 (menu-bar-lines . 0)
                                 (tool-bar-lines . 0)
                                 (unsplittable . t)
                                 (left-fringe . 0)))

(setq ace-jump-mode-scope 'window)
(setq password-cache t)
(setq password-cache-expiry nil) ;;duration of process
(setq use-dialog-box nil)


(setq emacs-tags-table-list
           '("~/.emacs.d" ".emacs.d/el-get"))

(setq desktop-files-not-to-save "^$") ;; do save tramp buffers
(setq desktop-restore-eager 10)       ;; load them lazily

;; try to load desktops manually with bookmark+
(desktop-save-mode -1)
(savehist-mode 1)

(put 'narrow-to-region 'disabled nil)

;;(setq desktop-path (add-to-list 'desktop-path "~/.emacs.d/.desktops"))
;; ready
(server-mode t)

;; TODO: need to do this after load
(diminish 'yas-minor-mode "y")
(diminish 'eproject-mode "P")
(diminish 'autopair-mode)
(diminish 'global-visual-line-mode)
(diminish 'rinari-minor-mode "`")
(diminish 'ruby-end-mode)
;(diminish 'rails-minor-mode)
(diminish 'eldoc-mode)

;(add-hook 'robe-mode-hook '(lambda ()(diminish 'robe-mode "\u03BB")))
;(add-hook 'flymake-mode-hook '(lambda ()(diminish 'flymake-mode " make ")))
;(add-hook 'rails-controller-minor-mode-hook '(lambda ()(diminish 'rails-controller-minor-mode)))
;(add-hook 'rails-model-minor-mode-hook '(lambda ()(diminish 'rails-model-minor-mode)))
;(add-hook 'rails-view-minor-mode-hook '(lambda ()(diminish 'rails-view-minor-mode)))


(rename-modeline "ruby-mode" ruby-mode "R")
(rename-modeline "lisp-mode" emacs-lisp-mode "()")
(rename-modeline "shell" shell-mode "$")

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(flyspell-prog-mode)
(setq rails-tags-command "ctags -e --Ruby-kinds=cfmF -o %s -R %s") ;;all kinds, don't append
(setq rails-tags-dirs '(".")) ;;all

;; for jabber:
(setq starttls-extra-arguments
      '("--insecure" "--no-ca-verification"))


;; for pianobar: <esc>[2k
(defconst ansi-color-drop-regexp
  "\033\\[\\([ABCDsuK]\\|2J\\|2K\\|=[0-9]+[hI]\\|[0-9;]*[Hf]\\)"
  "Regexp that matches ANSI control sequences to silently drop.")



(add-hook 'after-init-hook
          (lambda ()
            (load-theme 'misterioso t)
            ;; (switch-to-buffer-other-window (get-buffer "*scratch*"))
            (set-cursor-color "#ffff00")
            ;; (spawn-shell "*local*")
            (delete-other-windows)
            ))

(add-hook 'emacs-startup-hook
          (lambda()
            (if (yes-or-no-p "connect?")
                (progn
                  (wl)
                  (jabber-connect-all)))
            (org-agenda-list)))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
 '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))))
 '(magit-diff-add ((t (:foreground "chartreuse"))) t)
 '(magit-diff-del ((t (:foreground "red1"))) t)
 '(magit-diff-file-header ((t (:inherit diff-file-header :foreground "black"))) t)
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :foreground "black"))) t)
 '(magit-item-highlight ((t nil)) t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(org-latex-pdf-process (quote ("pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))
 '(tab-always-indent (quote complete)))
