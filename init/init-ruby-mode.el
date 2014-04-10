(add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec" . ruby-mode))
(add-to-list 'auto-mode-alist '("json_builder" . ruby-mode))
(add-to-list 'auto-mode-alist '("rxml" . ruby-mode))
(add-to-list 'auto-mode-alist '("hamlc" . haml-mode))

(defvar zeus-fast-rails "SF=true PAGER=cat DYLD_LIBRARY_PATH=$ORACLE_HOME USE_RAILS_3=true ")
(defun zeus-start ()
  (interactive)
  (spawn-shell "*zeus-start*" '(". ~/.bash_profile" "cd .")) ; rvm loading fails !
  (insert (concat zeus-fast-rails " zeus start"))
  (comint-send-input)
  (buffer-disable-undo))

; prevent prompt about rspec command getting set in .dir-locals.el
(put 'rspec-spec-command 'safe-local-variable #'stringp)

;; robe needs to set up a sentinel to set robe-running when buffer killed
;; (require 'robe)
;; (defun zeus-console ()
;;   (interactive)
;;   (rinari-console "zeus console")
;;   (robe-start))



;; @wip
;; (add-to-list 'align-rules-list '((ruby-hash
;;                                   (regexp . "=>")
;;                                   (group 1)
;;                                   (modes '(ruby-mode)))))
;;   (python-assignment
;;   (regexp . "[^=!<> 	\n]\\(\\s-*\\)=\\(\\s-*\\)\\([^>= 	\n]\\|$\\)")
;;   (group 1 2)
;;   (modes quote
;;          (python-mode))
;;   (tab-stop))
;; )

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
