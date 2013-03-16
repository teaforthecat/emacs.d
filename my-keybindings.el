;; needs placement:
;; extend-selection
;; org-set-tags-to
;; find-lisp-find-dired
;; find-lisp-find-dired-subdirectories
;; wl-summary-yank-saved-message
;; wl-summary-save-current-message





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
         (global-set-key (kbd ,(format "C-%s" (upcase (format "%s" key)))) ,shift-command ))))


(defmacro M (key command &optional shift-command)
 `(progn
    (global-set-key (kbd ,(format "M-%s" key)) ,command)
    (if ,shift-command
        (global-set-key (kbd ,(format "M-%s" (upcase (format "%s" key)))) ,shift-command ))))

(defun G (key command)
  (global-set-key key command))


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
(M "SPC" 'compile)
;yp.,'
(M ";" 'undo-tree-undo)
(M ":" 'undo-tree-redo)
(M y   'browse-kill-ring)        ;timid
(M p   'subword-kill)
(M "." 'subword-backward-kill)
(M "'" 'ido-switch-buffer-other-window) ;timid
;54321`
(M 5 'query-replace)
(M 4 'split-window-horizontally)
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
;;(C b 'browse-kill-ring 'browse-kill-ring-insert-and-quit)

(C w 'close-current-buffer)
(C r 'comment-or-uncomment-region)

(C f 'sudo-find-file)

; left hand
(C 5 'find-lisp-find-dired)             ;important
(C 4 'find-grep)                        ;important
(C 3 'find-file-at-point)               ;important
(C 2 'find-tag)                         ;important
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

(global-set-key (kbd "<f7>") 'pianobar)


;; C-x-* Initialize apps
(G (kbd "C-x g") 'magit-status)
(G (kbd "C-x f") 'recentf-open-files)
(G (kbd "C-x -") 'goto-line)
(G (kbd "C-M-s") 'ioccur)
(G (kbd "C-x k") 'kill-this-buffer)



;; TODO set these
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
;; (ergoemacs-global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c C-x C-j") 'org-clock-goto)
;; (ergoemacs-global-set-key (kbd "<C-tab>") 'magit-show-only-files)


;; edit

;; (ergoemacs-global-set-key (kbd "M-<f5>") 'flyspell-correct-word-before-point)
;(ergoemacs-global-set-key (kbd "<f6>") 'whitespace-mode)
;(ergoemacs-global-set-key (kbd "M-<f6>") 'whitespace-cleanup)
;(ergoemacs-global-set-key (kbd "<f5>") 'flyspell-mode)
;(ergoemacs-global-set-key (kbd "M-<f7>") 'pianobar)
;(ergoemacs-global-set-key (kbd "<f9>") 'flymake-mode)

(defvar movement-mode)
(add-to-list 'minor-mode-alist '(movement-mode movement-mode) t)

(defvar movement-mode-map
  (let ((map (make-sparse-keymap)))
     (define-key map (kbd "C-t") `previous-multiframe-window)
     (define-key map (kbd "C-h") `other-window)
     (define-key map (kbd "M-n") `forward-char)
     (define-key map (kbd "M-o") `eproject-find-file)
     (define-key map (kbd "M-g" ) `keyboard-quit)
     (define-key map (kbd "M-z" ) `undo-tree-undo)
     (define-key map (kbd "M-Z" ) `undo-tree-redo)
     map))

(add-to-list 'minor-mode-map-alist `(movement-mode . ,movement-mode-map) t)


(eval-after-load 'dired
  ;; Brash Bindings C-h C-k C-o C-t C-S-b C-n C-p M-everything
  '(progn
     (define-key dired-mode-map (kbd "C-t") `previous-multiframe-window)
     (define-key dired-mode-map (kbd "C-h") `other-window)
     (define-key dired-mode-map (kbd "M-g" ) `keyboard-quit)
     (define-key dired-mode-map "e" `dired-up-directory)
     (define-key dired-mode-map "o" `dired-display-file)
     (define-key dired-mode-map "k" `dired-kill-subdir)))


(eval-after-load 'ioccur
  '(progn
     (define-key ioccur-mode-map "d" `ioccur-jump-without-quit)
     (define-key ioccur-mode-map "k" `ioccur-jump-and-quit)
     (define-key ioccur-mode-map "n" `ioccur-next-line)
     (define-key ioccur-mode-map "p" `ioccur-precedent-line)
     (define-key ioccur-mode-map "N" `ioccur-scroll-down)
     (define-key ioccur-mode-map "P" `ioccur-scroll-up)))



(eval-after-load 'ibuffer
  '(progn
     (define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)
     (define-key ibuffer-mode-map (kbd "M-RET") 'ibuffer-bs-toggle-all)
     (define-key ibuffer-mode-map (kbd "TAB") 'ibuffer-toggle-filter-group)))

(eval-after-load 'magit
  '(progn
     (define-key magit-mode-map (kbd "C-\t") 'magit-show-only-files)))


(eval-after-load 'rspec
  '(progn
     (define-key rspec-mode-keymap (kbd "C-c v s") `rspec-verify-single)))


(eval-after-load 'shell
  ;; Brash Bindings: C-d, C-e, C-s, C-., M-RET, M-?, C-M-l, M-n, M-p, M-r  
  '(progn
     (define-key shell-mode-map (kbd "M-r") 'subword-forward)
     (define-key shell-mode-map (kbd "M-n") 'forward-char)
     (define-key shell-mode-map (kbd "C-s") 'comint-history-isearch-backward)
     (define-key shell-mode-map (kbd "C-.") 'comint-previous-input)
     (define-key shell-mode-map (kbd "C-e") 'comint-next-input)))

(eval-after-load 'slime
  '(progn
     (define-key slime-mode-map (kbd "M-n") 'forward-char)))



;timid
(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-and-exit)
(define-key minibuffer-local-map (kbd "C-.") 'backward-kill-word)



(if (string-match "apple-darwin" system-configuration)
    (global-set-key [f11] 'ns-toggle-fullscreen)
  (global-set-key [f11] 'fullscreen))

(provide 'my-keybindings)


; existing awesomeness to remember
;; (M $ ispell-word)
;; (C "[" 'escape)
;; (C q 'quoted-insert)
;; C-M\ 'indent-region
;; M-/ 'dabbrev-expand
;; notes:

;; mode-maps
;; (apropos-variable "-mode-map$" (quote (4)))
;; mode-hooks
;; (apropos-variable "-mode-hook$" (quote (4)))


