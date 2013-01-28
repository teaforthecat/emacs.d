(ergoemacs-global-set-key "\M-x" 'execute-extended-command)
(ergoemacs-global-set-key (kbd "C-p") 'nil)

;; move
(ergoemacs-global-set-key "\M-d" 'beginning-of-buffer)
(ergoemacs-global-set-key "\M-D" 'end-of-buffer)
(ergoemacs-global-set-key "\M-H" 'move-beginning-of-line)
(ergoemacs-global-set-key "\M-N" 'move-end-of-line)
(ergoemacs-global-set-key (kbd "C-x -") 'goto-line)
(ergoemacs-global-set-key (kbd "M-O") 'isearch-occur)
(ergoemacs-global-set-key (kbd "M-C-S") 'isearch-other-window)
(ergoemacs-global-set-key (kbd "C-t") 'move-cursor-next-pane)
(ergoemacs-global-set-key (kbd "C-h") 'move-cursor-previous-pane)

(ergoemacs-global-set-key (kbd "C-f") 'sudo-find-file)

;; edit
(ergoemacs-global-set-key "\M-\\" 'yas/expand)
(ergoemacs-global-set-key "\M-j" 'clipboard-kill-ring-save)
(ergoemacs-global-set-key "\M-k" 'clipboard-yank)
(ergoemacs-global-set-key "\C-k" 'kill-whole-line)
(ergoemacs-global-set-key (kbd "C-.") 'comint-previous-input)
(ergoemacs-global-set-key "\C-e" 'comint-next-input)
(ergoemacs-global-set-key (kbd "C-r") 'comment-or-uncomment-region)
(ergoemacs-global-set-key (kbd "M-<f5>") 'flyspell-correct-word-before-point)
(ergoemacs-global-set-key (kbd "C-=") 'select-text-in-quote)
(ergoemacs-global-set-key (kbd "C-M-,") 'kmacro-call-macro)
(ergoemacs-global-set-key (kbd "M-e") 'delete-backward-char-untabify)

;;--edit in app --(move to app key maps someday)
(ergoemacs-global-set-key (kbd "C-x 9") 'dired-omit-mode)

(ergoemacs-global-set-key (kbd "<C-tab>") 'magit-show-only-files)
(ergoemacs-global-set-key (kbd "C-c li") 'org-clock-in)
(ergoemacs-global-set-key (kbd "C-c lo") 'org-clock-out)
(ergoemacs-global-set-key (kbd "C-c lu") 'org-clock-update-time-maybe)
(ergoemacs-global-set-key (kbd "<M-kp-right>") 'org-table-insert-column)
(ergoemacs-global-set-key (kbd "<M-kp-down>") 'org-table-insert-row)
(ergoemacs-global-set-key (kbd "C-x rv") 'list-registers)


;;(ergoemacs-global-set-key (kbd "") 'org-insert-subheading)
;; buffer
(ergoemacs-global-set-key "\M-X" 'dired)
(ergoemacs-global-set-key "\M-w" 'next-buffer)
(ergoemacs-global-set-key "\M-m" 'previous-buffer)
(ergoemacs-global-set-key "\M-o" 'ido-switch-buffer)
(ergoemacs-global-set-key "\M-v" 'ibuffer)
(ergoemacs-global-set-key (kbd "C-c C-r") 'rename-file-and-buffer)
(ergoemacs-global-set-key (kbd "M-'") 'switch-to-buffer-other-window)
(ergoemacs-global-set-key (kbd "C-c e b") 'eval-buffer)
(ergoemacs-global-set-key (kbd "C-x k") 'close-current-buffer)
;; apps
(ergoemacs-global-set-key (kbd "C-c r") 'remember)
(ergoemacs-global-set-key (kbd "C-x g") 'magit-status)
(ergoemacs-global-set-key (kbd "C-c a") 'org-agenda)

(if (string-match "apple-darwin" system-configuration)
    (global-set-key [f11] 'ns-toggle-fullscreen)
  (global-set-key [f11] 'fullscreen))

(ergoemacs-global-set-key (kbd "<f6>") 'whitespace-mode)
(ergoemacs-global-set-key (kbd "M-<f6>") 'whitespace-cleanup)
(ergoemacs-global-set-key (kbd "<f5>") 'flyspell-mode)
(ergoemacs-global-set-key (kbd "M-<f7>") 'pianobar)
(ergoemacs-global-set-key (kbd "<f9>") 'flymake-mode)

;; servers
(ergoemacs-global-set-key (kbd "<C-f1>") 'django-server)
(ergoemacs-global-set-key (kbd "<C-f2>") 'django-testserver)
(ergoemacs-global-set-key (kbd "<C-f3>") 'django-shell)

;;(ergoemacs-global-unset-key (kbd "C-s"))
;; (wl-summary-yank-saved-message)
;; (wl-summary-save-current-message)

(define-key global-map (kbd "C-s") 'save-buffer)


(eval-after-load 'slime
  '(progn
     (define-key slime-mode-map (kbd "M-n") 'forward-char)
     ))

(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map (kbd "C-s") 'comint-history-isearch-backward)
     ;; (define-key global-map (kbd "C-s") 'save-buffer)
     ))


(eval-after-load 'dired '(progn
                           (define-key dired-mode-map "e" `dired-up-directory)
                           (define-key dired-mode-map "o" `dired-display-file)
                           (define-key dired-mode-map "k" `dired-kill-subdir)))
                           ;; v = view-mode

(eval-after-load 'rspec
  '(progn
     (define-key rspec-mode-keymap (kbd "C-c v s")
       `rspec-verify-single)))

;;try: find-lisp-find-dired
;;try: find-lisp-find-dired-subdirectories

(ergoemacs-global-set-key (kbd "C-\-") 'toggle-hiding)
(ergoemacs-global-set-key (kbd "C-\\") 'toggle-selective-display)
;; (eval-after-load 'w3m
;;   '(progn
;;      (define-key w3m-mode-map "f" 'w3m-next-form)
;;     ))

(global-set-key (kbd "C-c C-x C-j") 'org-clock-goto)
;; (org-set-tags-to)

(eval-after-load 'ioccur '(progn
  (define-key ioccur-mode-map "d" `ioccur-jump-without-quit)
  (define-key ioccur-mode-map "k" `ioccur-jump-and-quit)
  (define-key ioccur-mode-map "n" `ioccur-next-line)
  (define-key ioccur-mode-map "p" `ioccur-precedent-line)
  (define-key ioccur-mode-map "N" `ioccur-scroll-down)
  (define-key ioccur-mode-map "P" `ioccur-scroll-up)))

;; jump points
(ergoemacs-global-set-key (kbd "C-1") 'ioccur)
(ergoemacs-global-set-key (kbd "C-2") 'find-tag)
(ergoemacs-global-set-key (kbd "C-3") 'find-file-at-point)
(ergoemacs-global-set-key (kbd "C-4") 'find-grep)
(ergoemacs-global-set-key (kbd "C-5") 'find-lisp-find-dired)
(ergoemacs-global-set-key (kbd "C-x <f9>") 'find-lisp-find-dired-subdirectories)

;; (flyspell-correct-word-before-point)
;;(ergoemacs-global-set-key "\" 'bookmark-jump)
;;(ergoemacs-global-set-key "\" 'bookmark-set)
;;(ergoemacs-global-set-key "\" 'term-send-up)
;;(ergoemacs-global-set-key "\" 'term-send-down)
;; 'compare-windows


(eval-after-load 'ibuffer
  '(progn
     (define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)
     (define-key ibuffer-mode-map (kbd "M-RET") 'ibuffer-bs-toggle-all)
     (define-key ibuffer-mode-map (kbd "TAB") 'ibuffer-toggle-filter-group)
     ))

(provide 'my-keybindings)
