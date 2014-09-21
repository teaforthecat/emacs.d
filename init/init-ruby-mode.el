(add-to-list 'auto-mode-alist '("GemFile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec" . ruby-mode))
(add-to-list 'auto-mode-alist '("json_builder" . ruby-mode))
(add-to-list 'auto-mode-alist '("rxml" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.thor" . ruby-mode))
(add-to-list 'auto-mode-alist '("hamlc" . haml-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
;; rspec-mode Version: 1.3


(defvar zeus-fast-rails "SF=true PAGER=cat DYLD_LIBRARY_PATH=$ORACLE_HOME USE_RAILS_3=true ")
(defun zeus-start ()
  (interactive)
  (spawn-shell "*zeus-start*" '(". ~/.bash_profile" "cd .")) ; rvm loading fails !
  (insert (concat zeus-fast-rails " zeus start"))
  (comint-send-input)
  (buffer-disable-undo))

; prevent prompt about rspec command getting set in .dir-locals.el
(put 'rspec-spec-command 'safe-local-variable #'stringp)

(defadvice rspec-end-of-buffer-target-window (after make-editable activate )
  "make comint buffer editable; ad-get-arg is buf-name"
  (let* ((com-buffer (get-buffer (ad-get-arg 0)))
         (com-window (get-buffer-window com-buffer)))
    (save-excursion
      (progn
        (select-window com-window)
        (read-only-mode -1)
        (shell-mode)))))

;; (defvar ac-sources ())
;; (defun add-ac-source-robe ()
;;   (set (make-local-variable 'ac-sources)
;;        (append ac-sources '(ac-source-robe))))
;; (add-hook 'ruby-mode-hook 'add-ac-source-robe)
(require 'rspec-mode)
(add-hook 'dired-mode-hook 'rspec-dired-mode)

(setq enh-ruby-program "/Users/cthompson/.rbenv/shims/ruby")

(add-hook 'enh-ruby-mode-hook 'rinari-minor-mode)
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-hook 'enh-ruby-mode-hook 'eldoc-mode)  ;for yard-mode completions
