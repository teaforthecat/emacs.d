(defmacro .emacs-curry (function &rest args)
  `(lambda () (interactive)
     (,function ,@args)))

(defmacro .emacs-eproject-key (key command)
  (cons 'progn
        (loop for (k . p) in (list (cons key 4) (cons (upcase key) 1))
              collect
              `(global-set-key
                (kbd ,(format "C-x p %s" k))
                (.emacs-curry ,command ,p)))))

(.emacs-eproject-key "k" eproject-kill-project-buffers)
(.emacs-eproject-key "v" eproject-revisit-project)
(.emacs-eproject-key "b" eproject-ibuffer)
(.emacs-eproject-key "o" eproject-open-all-project-files)

(defmacro C (key command)
  `(global-set-key (kbd ,(format "C-%s" key)) ,command))

(defmacro M (key command)
  `(global-set-key (kbd ,(format "M-%s" key)) ,command))

; move cursor (right hand)
(M t 'next-line)
(M c 'previous-line)
(M n 'forward-char)
(M h 'backward-char)
(M r 'subword-forward)
(M g 'subword-backward)
(M d 'beginning-of-buffer)
(M m 'previous-buffer)
(M w 'next-buffer)
(M l 'recenter-top-bottom)              ;timid

; shortcuts
;right hand
(M b 'keyboard-quit)
(M v 'eproject-ibuffer)                 ;new
(M z 'toggle-letter-case)               ;timid
(M s 'ace-jump-mode)                    ;new
(M - 'comment-dwim)                     ;timid
(M x 'execute-extended-command)         ;timid
(M f 'nil)                              ;empty

;(M \ 'yas/expand)                       ;replace
(M = 'count-words-region)
(M / 'dabbrev-expand)                   ;default
(M "]" 'nil)                            ;empty
(M "[" 'nil)                            ;empty

(M 0 'delete-window)
(M 9 'nil)
(M 8 'extend-selection)                 ;important
(M 7 'nil)
(M 7 'nil)
(M 6 'nil)

; left hand
(M 5 'query-replace)
(M 4 'split-window-vertically)
(M 3 'delete-other-windows)
(M 2 'nil)
(M 1 'nil)
(M "`" 'switch-to-next-frame)           ;timid
(M "'" 'ido-switch-buffer-other-window) ;timid
(M o   'ido-switch-buffer)              ;muscle conflicts with M-a
(M a   'execute-extended-command)       ;dup of M-x

; edit (left hand)
(M "," 'shrink-whitespaces)             ;timid
(M "." 'subword-backward-kill)
(M p   'subword-kill)
(M y   'call-keyword-completion)        ;timid
(M i   'kill-line)                      ;timid
(M u   'delete-char)
(M e   'autopair-backspace)
(M ";" 'undo-tree-undo)
(M q   'kill-region)
(M j   'clipboard-kill-ring-save)
(M k   'clipboard-yank)

(M <f1> 'nil)
(M <f2> 'nil)
(M <f3> 'nil)
(M <f4> 'nil)
(M <f4> 'nil)
(M <f5> 'flyspell-correct-word-before-point)
(M <f6> 'whitespace-cleanup)
(M <f7> 'pianobar)
(M <f8> 'nil)
(M <f9> 'nil)
(M <f10> 'nil)
(M <f11> 'nil)
(M <f12> 'nil)



;--------------

;control

; right hand
(C t 'move-cursor-next-pane)
(C h 'move-cursor-previous-pane)
(C n 'new-empty-buffer)                 ;remove
(C s 'save-buffer)
(C - 'toggle-hiding)                    ;void
(C b 'nil)
(C m 'autopair-newline)                  ;timid
(C w 'close-current-buffer)
(C v 'nil)
(C z 'nil)
(C = 'select-text-in-quote)             ;important
(C / 'undo-tree-undo)                   ;dup of M-;
(C l 'nil)
(C r 'comment-or-uncomment-region)
;(C c 'prefix)
(C g 'keyboard-quit)
(C f 'sudo-find-file)
(C "]" 'abort-recursive-edit)           ;timid
;(C "[" 'escape)                        ;built-in
(C 9 'nil)
(C 8 'nil)
(C 7 'nil)
(C 6 'nil)

; left hand
(C 5 'find-lisp-find-dired)             ;dup of M-5
(C 4 'find-grep)                        ;dup
(C 3 'find-file-at-point)               ;dup
(C 2 'find-tag)                         ;dup
(C 1 'ioccur)                           ;dup

(C 5 'find-lisp-find-dired)             ;important
(C 4 'find-grep)                        ;important
(C 3 'find-file-at-point)               ;important
(C 2 'find-tag-name)                    ;important
(C 1 'ioccur)                           ;important

(C "'" 'nil)
(C "," 'nil)
(C "." 'comint-previous-input)
(C p 'nil)
(C y 'nil)
(C i 'indent-for-tab-command)
;(C u 'universal-argument)               ;built-in
(C e 'comint-next-input)
(C o 'ido-find-file)                    ;important
(C a 'mark-whole-buffer)
(C <tab> 'magit-show-only-files)

(C ";" 'nil)
;(C q 'quoted-insert)                   ;built-in
(C j 'nil)
(C k 'kill-whole-line)
;(C x 'prefix)                          ;prefix
;(C <f2> 'void)
;(C <f3> 'mac)
(C <f4> 'nil)
(C <f5> 'nil)
(C <f6> 'nil)
(C <f7> 'nil)
;(C <f8> 'mac)???
(C <f7> 'nil)
(C <f8> 'nil)
(C <f9> 'nil)
(C <f10> 'nil)
(C <f11> 'nil)
(C <f12> 'nil)



; function keys
(global-set-key (kbd "<f6>") 'whitespace-mode)
(global-set-key (kbd "<f5>") 'flyspell-mode)
(global-set-key (kbd "<f9>") 'flymake-mode)




;; mode-maps
;; (apropos-variable "-mode-map$" (quote (4)))
;; mode-hooks
;; (apropos-variable "-mode-hook$" (quote (4)))

;; (ergoemacs-global-set-key "\M-x" 'execute-extended-command)
;; (ergoemacs-global-set-key (kbd "C-p") 'nil)

;; move
;; (ergoemacs-global-set-key "\M-d" 'beginning-of-buffer)
(ergoemacs-global-set-key "\M-D" 'end-of-buffer)
(ergoemacs-global-set-key "\M-H" 'move-beginning-of-line)
(ergoemacs-global-set-key "\M-N" 'move-end-of-line)
(ergoemacs-global-set-key (kbd "C-x -") 'goto-line)
(ergoemacs-global-set-key (kbd "M-O") 'isearch-occur)
(ergoemacs-global-set-key (kbd "M-C-S") 'isearch-other-window)
;; (ergoemacs-global-set-key (kbd "C-t") 'move-cursor-next-pane)
;; (ergoemacs-global-set-key (kbd "C-h") 'move-cursor-previous-pane)

;; (ergoemacs-global-set-key (kbd "C-f") 'sudo-find-file)

;; edit
(ergoemacs-global-set-key "\M-\\" 'yas/expand)
;; (ergoemacs-global-set-key "\M-j" 'clipboard-kill-ring-save)
;; (ergoemacs-global-set-key "\M-k" 'clipboard-yank)
(ergoemacs-global-set-key "\C-k" 'kill-whole-line)
;; (ergoemacs-global-set-key (kbd "C-.") 'comint-previous-input)
;; (ergoemacs-global-set-key "\C-e" 'comint-next-input)
;; (ergoemacs-global-set-key (kbd "C-r") 'comment-or-uncomment-region)
;; (ergoemacs-global-set-key (kbd "M-<f5>") 'flyspell-correct-word-before-point)
;; (ergoemacs-global-set-key (kbd "C-=") 'select-text-in-quote)
(ergoemacs-global-set-key (kbd "C-M-,") 'kmacro-call-macro)
;;(ergoemacs-global-set-key (kbd "M-e") 'autopair-backward-delete) ;;except minibuffer-map
;;(ergoemacs-global-set-key (kbd "M-e") 'delete-backward-char-untabify) ?


;;--edit in app --(move to app key maps someday)
(ergoemacs-global-set-key (kbd "C-x 9") 'dired-omit-mode)

;; (ergoemacs-global-set-key (kbd "<C-tab>") 'magit-show-only-files)
(ergoemacs-global-set-key (kbd "C-c li") 'org-clock-in)
(ergoemacs-global-set-key (kbd "C-c lo") 'org-clock-out)
(ergoemacs-global-set-key (kbd "C-c lu") 'org-clock-update-time-maybe)
(ergoemacs-global-set-key (kbd "<M-kp-right>") 'org-table-insert-column)
(ergoemacs-global-set-key (kbd "<M-kp-down>") 'org-table-insert-row)
(ergoemacs-global-set-key (kbd "C-x rv") 'list-registers)


;;(ergoemacs-global-set-key (kbd "") 'org-insert-subheading)
;; buffer
(ergoemacs-global-set-key "\M-X" 'dired)
;; (ergoemacs-global-set-key "\M-w" 'next-buffer)
;; (ergoemacs-global-set-key "\M-m" 'previous-buffer)
;; (ergoemacs-global-set-key "\M-o" 'ido-switch-buffer)
;; (ergoemacs-global-set-key "\M-v" 'ibuffer)
(ergoemacs-global-set-key (kbd "C-c C-r") 'rename-file-and-buffer)
;; (ergoemacs-global-set-key (kbd "M-'") 'switch-to-buffer-other-window)
(ergoemacs-global-set-key (kbd "C-c e b") 'eval-buffer)
(ergoemacs-global-set-key (kbd "C-x k") 'close-current-buffer)
;; apps
(ergoemacs-global-set-key (kbd "C-c r") 'org-capture)
(ergoemacs-global-set-key (kbd "C-x g") 'magit-status)
(ergoemacs-global-set-key (kbd "C-c a") 'org-agenda)

(if (string-match "apple-darwin" system-configuration)
    (global-set-key [f11] 'ns-toggle-fullscreen)
  (global-set-key [f11] 'fullscreen))

;; (ergoemacs-global-set-key (kbd "<f6>") 'whitespace-mode)
;; (ergoemacs-global-set-key (kbd "M-<f6>") 'whitespace-cleanup)
;; (ergoemacs-global-set-key (kbd "<f5>") 'flyspell-mode)
;; (ergoemacs-global-set-key (kbd "M-<f7>") 'pianobar)
;; (ergoemacs-global-set-key (kbd "<f9>") 'flymake-mode)

;; servers
;; (ergoemacs-global-set-key (kbd "<C-f1>") 'django-server)
;; (ergoemacs-global-set-key (kbd "<C-f2>") 'django-testserver)
;; (ergoemacs-global-set-key (kbd "<C-f3>") 'django-shell)

;;(ergoemacs-global-unset-key (kbd "C-s"))
;; (wl-summary-yank-saved-message)
;; (wl-summary-save-current-message)

;; (define-key global-map (kbd "C-s") 'save-buffer)


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

;; (ergoemacs-global-set-key (kbd "C-\-") 'toggle-hiding)
;; (ergoemacs-global-set-key (kbd "C-\\") 'toggle-selective-display)
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
