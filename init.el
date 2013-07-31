(require 'reset);; should load first
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/contrib")
(add-to-list 'load-path "~/.emacs.d")
(load-file "init-packages.el")
(require 'contrib-functions)
(require 'my-functions)
(require 'my-macros)
(require 'my-keybindings)




; TODO: move to custom settings file
(add-hook 'write-contents-functions 'delete-trailing-whitespace)
(display-time)
(flyspell-mode 0)
(setq visible-bell t)
(setq speedbar-show-unknown-files t)
(setq speedbar-frame-parameters '((minibuffer)
                                 (width . 60)
                                 (border-width . 0)
                                 (menu-bar-lines . 0)
                                 (tool-bar-lines . 0)
                                 (unsplittable . t)
                                 (left-fringe . 0)))

(set-face-attribute 'default nil
                :family "Inconsolata" :height 165 :weight 'normal)



(setq ace-jump-mode-scope 'window)
(setq password-cache t)
(setq password-cache-expiry nil) ;;duration of process
(setq use-dialog-box nil)

(setq bookmark-file "~/.emacs.d/private/bookmarks")

(setq emacs-tags-table-list
           '("~/.emacs.d" ".emacs.d/el-get"))


(server-mode t)


;; Enabled minor modes: Auto-Composition Auto-Compression Auto-Encryption
;; Autopair Autopair-Global Blink-Cursor Column-Number Delete-Selection
;; Diff-Auto-Refine Display-Time Eproject File-Name-Shadow Font-Lock
;; Global-Auto-Revert Global-Font-Lock Global-Subword Global-Undo-Tree
;; Global-Visual-Line Ido-Everywhere Line-Number Mouse-Wheel Movement
;; Recentf Server Shell-Dirtrack Show-Paren Subword Tooltip
;; Transient-Mark Undo-Tree Visual-Line Winner Yas Yas-Global
;; TODO: need to do this after load
(diminish 'yas-minor-mode "y")
(diminish 'eproject-mode "P")
(diminish 'autopair-mode)
(diminish 'global-visual-line-mode)
;; not sure why robe-mode is not loaded yet.
(add-hook 'robe-mode-hook '(lambda ()(diminish 'robe-mode "\u03BB")))
(add-hook 'flymake-mode-hook '(lambda ()(diminish 'flymake-mode "\u2713")))


(diminish 'rinari-minor-mode "`")
(diminish 'ruby-end-mode)
(diminish 'rails-minor-mode)
(diminish 'eldoc-mode)


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

(add-hook 'after-init-hook
          (lambda ()
            (load-theme 'misterioso t)
            (switch-to-buffer-other-window (get-buffer "*scratch*"))
            (set-cursor-color "#ffff00")
            (org-agenda-list)
            (spawn-shell "*local*")
            (delete-other-windows)
            ))

(add-hook 'emacs-startup-hook
          (lambda()
            (if (yes-or-no-p "connect?")
                (progn
                  (wl)
                  (jabber-connect-all)))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
 '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))) t)
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
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-stream-type (quote ssl))
 '(tab-always-indent (quote complete))
 '(wl-smtp-connection-type (quote starttls))
 '(wl-smtp-posting-server "mail1.office.gdi"))
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
