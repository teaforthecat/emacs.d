(cd "~");; not sure what is up about this
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(add-to-list 'load-path "~/.emacs.d")
(require 'reset)

;; (setq debug-on-error t)
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


;; record keystrokes, analyze later
;; uses contrib-function macro
(defun store-keystrokes ()
  "saves keystrokes to file to study later"
  (let ((dribble-file (make-temp-name (expand-file-name "~/.emacs.d/lossage-")))
        (dribble-persistent (expand-file-name "~/.emacs.d/lossage.txt")))
    (open-dribble-file dribble-file)
    (dribble-append-on-exit dribble-file dribble-persistent)))
(store-keystrokes)


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

(setq whitespace-line-column  80
      whitespace-style '(face tabs spaces trailing lines space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark)
      require-final-newline  t)

;; this is buffer local:
;;(add-hook 'write-contents-functions 'whitespace-cleanup)

;; this is global:
(add-hook 'before-save-hook 'whitespace-cleanup)

(display-time)

(setq ffip-find-options "-not -regex \".*svn.*\" -not -path '*/.bundle/*' -not -path '*/contrib/*'")

;; (setq truncate-lines nil)
(setq visible-bell t)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
;(setq tab-always-indent 'complete) ;don't list files on tab indentation
;(setq tab-always-indent t)
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

;; not sure this is used:?
;; (setq emacs-tags-table-list
;;            '("~/.emacs.d" ".emacs.d/el-get"))

(setq tags-table-list '("~/.emacs.d/"  "~/.emacs.d/el-get/"))


;;consider, it seems to cancel ido-mode
;;(icomplete-mode t)
;;(flx-ido-mode 1)

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
(diminish 'yas-minor-mode)
(diminish 'eproject-mode)
(diminish 'autopair-mode)
(diminish 'global-visual-line-mode)
(diminish 'rinari-minor-mode "`")
(diminish 'ruby-end-mode)
;(diminish 'rails-minor-mode)
(diminish 'eldoc-mode)



;(add-hook 'robe-mode-hook '(lambda ()(diminish 'robe-mode "\u03BB")))
;;(add-hook 'flymake-mode-hook '(lambda ()(diminish 'flymake-mode)))
;(add-hook 'rails-controller-minor-mode-hook '(lambda ()(diminish 'rails-controller-minor-mode)))
;(add-hook 'rails-model-minor-mode-hook '(lambda ()(diminish 'rails-model-minor-mode)))
;(add-hook 'rails-view-minor-mode-hook '(lambda ()(diminish 'rails-view-minor-mode)))


(rename-modeline "ruby-mode" ruby-mode "Rb ")
(rename-modeline "lisp-mode" emacs-lisp-mode "() ")
(rename-modeline "shell" shell-mode "$ ")

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
; this might be causing a delay with pairs
;(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;;(flyspell-prog-mode) ;; does this cause problems with tramp? esp ruby
(setq rails-tags-command "ctags -e --Ruby-kinds=cfmF -o %s -R %s") ;;all kinds, don't append
(setq rails-tags-dirs '(".")) ;;all

;; for jabber:
(setq starttls-extra-arguments
      '("--insecure" "--no-ca-verification"))



(setq completion-cycle-threshold 6);;omg
(setq completion-auto-help 'lazy)



(add-hook 'after-init-hook
          (lambda ()
            ;; (load-theme 'misterioso t)
            (load-theme 'flatland t)
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




(require 'dash)
(rainbow-delimiters-mode 1)
;;TODO these setting should be per-mode and buffer-local:
(setq safe-local-variable-values
      '((whitespace-line-column . 80)
        (whitespace-style face trailing lines-tail)
        (require-final-newline . t)
        (ruby-compilation-executable . "ruby")
        (ruby-compilation-executable . "ruby1.8")
        (ruby-compilation-executable . "ruby1.9")
        (ruby-compilation-executable . "rbx")
        (ruby-compilation-executable . "jruby")))

; not sure why three times
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
 '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))))
 '(magit-diff-add ((t (:foreground "chartreuse"))))
 '(magit-diff-del ((t (:foreground "red1"))))
 '(magit-diff-file-header ((t (:inherit diff-file-header :foreground "black"))))
 '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :foreground "black"))))
 '(magit-item-highlight ((t nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/private/bookmarks")
 '(custom-safe-themes (quote ("6e05b0a83b83b5efd63c74698e1ad6feaddf69a50b15a8b4a83b157aac45127c" default)))
 '(fill-column 80))
