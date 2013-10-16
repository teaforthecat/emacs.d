(add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec" . ruby-mode))
(add-to-list 'auto-mode-alist '("json_builder" . ruby-mode))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (rvm-activate-corresponding-ruby)
;;             (ruby-end-mode)
;;             (flyspell-prog-mode)
;;             (flyspell-mode 0)))

;(add-hook 'ruby-mode-hook 'rinari-minor-mode)
;; (add-hook 'ruby-mode-hook 'robe-mode)

;; (defvar ac-sources ())
;; (defun add-ac-source-robe ()
;;   (set (make-local-variable 'ac-sources)
;;        (append ac-sources '(ac-source-robe))))


;; (add-hook 'ruby-mode-hook 'add-ac-source-robe)
