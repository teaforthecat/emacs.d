;; needs placement:
;; extend-selection
;; org-set-tags-to
;; find-lisp-find-dired
;; find-lisp-find-dired-subdirectories
;; wl-summary-yank-saved-message
;; wl-summary-save-current-message
;; browse-kill-ring
;; browse-kill-ring-insert-and-quit



;; needs placement in a keymap:
;; (C "." 'comint-previous-input)  ;move to comint-mode-keymap
;; (C e 'comint-next-input)        ;move to comint-mode-keymap
;; (C "\t" 'magit-show-only-files) ;move to magit-mode-keymap


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

 
(defmacro C (key command &optional shift-command)
  `(progn
     (global-set-key (kbd ,(format "C-%s" key)) ,command)
     (if ,shift-command
         (global-set-key (kbd ,(format "C-S-%s" (format "%s" key)) ) ,shift-command ))))


(defmacro M (key command &optional shift-command)
 `(progn
    (global-set-key (kbd ,(format "M-%s" key)) ,command)
    (if ,shift-command
        (global-set-key (kbd ,(format "M-S-%s" (format "%s" key)) ) ,shift-command ))))

(defun G (key command)
  (global-set-key key command))


(G (kbd "C--") 'undo-tree-undo)
(define-key global-map (kbd "C-s") 'save-buffer)

;; M Right Hand (movement)
;dhtns-
(M t 'next-line 'scroll-up)
(M h 'backward-char 'beginning-of-line)
(M n 'forward-char 'end-of-line)
(M s 'ace-jump-mode 'isearch-forward)                    ;new
(M - 'comment-dwim)                     ;timid
;bmwvz
(M b 'keyboard-quit)
(M m 'previous-buffer)
(M w 'next-buffer)
(M v 'eproject-ibuffer 'ibuffer)                 ;new
(M z 'toggle-letter-case)               ;timid
;fgcrl/=\
(M r 'subword-forward 'end-of-line)
(M g 'subword-backward 'beginning-of-line)
(M l 'recenter-top-bottom)              ;timid
(M c 'previous-line 'scroll-down)
(M = 'count-words-region)
;67890[]
(M 0 'delete-window)


; M Left Hand (editing)
;iueoa
(M i   'kill-line)                      ;timid
(M u   'delete-forward-char)
(M e   'delete-backward-char 'subword-backward-kill)
(M o   'ido-switch-buffer)              ;muscle conflicts with M-a
(M a   'execute-extended-command)       ;dup of M-x
;xkjq;
(M x 'execute-extended-command)         ;timid
(M k   'clipboard-yank)
(M j   'clipboard-kill-ring-save)
(M q   'kill-region)
(M ";" 'undo-tree-undo)
(M "SPC" 'dabbrev-expand)                   ;default
;yp.,'
(M y   'call-keyword-completion)        ;timid
(M p   'subword-kill)
(M "." 'subword-backward-kill)
(M "'" 'ido-switch-buffer-other-window) ;timid
;54321`
(M 5 'query-replace)
(M 4 'split-window-vertically)
(M 3 'delete-other-windows)
(M "`" 'switch-to-next-frame)           ;timid
(M <f5> 'flyspell-correct-word-before-point)
(M <f6> 'whitespace-cleanup)
(M <f7> 'pianobar)


;--------------

;control

; right hand
(C d 'duplicate-line-or-region)
(C h 'other-window)
(C t 'previous-multiframe-window)
(C n 'forward-page)
(C s 'save-buffer)
(C - 'undo-tree-undo)
(C b 'browse-kill-ring 'browse-kill-ring-insert-and-quit)

(C w 'close-current-buffer)
(C r 'comment-or-uncomment-region)

(C f 'sudo-find-file)

; left hand
(C 5 'find-lisp-find-dired)             ;important
(C 4 'find-grep)                        ;important
(C 3 'find-file-at-point)               ;important
(C 2 'find-tag-name)                    ;important
(C 1 'ioccur)                           ;important

(C p 'backward-page)
(C i 'indent-for-tab-command)
(C o 'eproject-find-file 'find-file)
(C a 'mark-whole-buffer)

(C k 'kill-whole-line)

    
; function keys
(global-set-key (kbd "<f6>") 'whitespace-mode)
(global-set-key (kbd "<f5>") 'flyspell-mode)
(global-set-key (kbd "<f9>") 'flymake-mode)


(G (kbd "C-x f") 'recentf-open-files)


;; C-x-* Initialize apps
(G (kbd "C-x g") 'magit-status)

;; TODO set these
;; (ergoemacs-global-set-key "\M-D" 'end-of-buffer)
;; (ergoemacs-global-set-key "\M-H" 'move-beginning-of-line)
;; (ergoemacs-global-set-key "\M-N" 'move-end-of-line)
;; (ergoemacs-global-set-key (kbd "C-x -") 'goto-line)
;; (ergoemacs-global-set-key (kbd "M-O") 'isearch-occur)
;; (ergoemacs-global-set-key (kbd "M-C-S") 'isearch-other-window)
;; (ergoemacs-global-set-key "\M-\\" 'yas/expand)
;; (ergoemacs-global-set-key "\C-k" 'kill-whole-line)
;; (ergoemacs-global-set-key (kbd "C-M-,") 'kmacro-call-macro)
;; (ergoemacs-global-set-key (kbd "C-x 9") 'dired-omit-mode)
;; (ergoemacs-global-set-key (kbd "C-c li") 'org-clock-in)
;; (ergoemacs-global-set-key (kbd "C-c lo") 'org-clock-out)
;; (ergoemacs-global-set-key (kbd "C-c lu") 'org-clock-update-time-maybe)
;; (ergoemacs-global-set-key (kbd "<M-kp-right>") 'org-table-insert-column)
;; (ergoemacs-global-set-key (kbd "<M-kp-down>") 'org-table-insert-row)
;; (ergoemacs-global-set-key (kbd "C-x rv") 'list-registers)
;; (ergoemacs-global-set-key "\M-X" 'dired)
;; (ergoemacs-global-set-key (kbd "C-c e b") 'eval-buffer)
;; (ergoemacs-global-set-key (kbd "C-x k") 'close-current-buffer)
;; (ergoemacs-global-set-key (kbd "C-c C-r") 'rename-file-and-buffer)
;; (ergoemacs-global-set-key (kbd "C-c r") 'org-capture)
;; (ergoemacs-global-set-key (kbd "C-x g") 'magit-status)
;; (ergoemacs-global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c C-x C-j") 'org-clock-goto)
;; (ergoemacs-global-set-key (kbd "<C-tab>") 'magit-show-only-files)
;; (ergoemacs-global-set-key (kbd "C-t") 'move-cursor-next-pane)
;; (ergoemacs-global-set-key (kbd "C-h") 'move-cursor-previous-pane)
;; (ergoemacs-global-set-key (kbd "C-f") 'sudo-find-file)


;; edit

;; (ergoemacs-global-set-key (kbd "M-<f5>") 'flyspell-correct-word-before-point)
;(ergoemacs-global-set-key (kbd "<f6>") 'whitespace-mode)
;(ergoemacs-global-set-key (kbd "M-<f6>") 'whitespace-cleanup)
;(ergoemacs-global-set-key (kbd "<f5>") 'flyspell-mode)
;(ergoemacs-global-set-key (kbd "M-<f7>") 'pianobar)
;(ergoemacs-global-set-key (kbd "<f9>") 'flymake-mode)




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


(eval-after-load 'ioccur '(progn
  (define-key ioccur-mode-map "d" `ioccur-jump-without-quit)
  (define-key ioccur-mode-map "k" `ioccur-jump-and-quit)
  (define-key ioccur-mode-map "n" `ioccur-next-line)
  (define-key ioccur-mode-map "p" `ioccur-precedent-line)
  (define-key ioccur-mode-map "N" `ioccur-scroll-down)
  (define-key ioccur-mode-map "P" `ioccur-scroll-up)))


(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-and-exit)

(eval-after-load 'ibuffer
  '(progn
     (define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)
     (define-key ibuffer-mode-map (kbd "M-RET") 'ibuffer-bs-toggle-all)
     (define-key ibuffer-mode-map (kbd "TAB") 'ibuffer-toggle-filter-group)
     ))

(if (string-match "apple-darwin" system-configuration)
    (global-set-key [f11] 'ns-toggle-fullscreen)
  (global-set-key [f11] 'fullscreen))

(provide 'my-keybindings)


; existing awesomeness to remember
;; (C _ 'undo-tree-redo)
;; (M $ ispell-word)
;; (C "[" 'escape)
;; (C q 'quoted-insert)



;; notes:

;; mode-maps
;; (apropos-variable "-mode-map$" (quote (4)))
;; mode-hooks
;; (apropos-variable "-mode-hook$" (quote (4)))


