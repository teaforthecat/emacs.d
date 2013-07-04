; sets movement-minor-mode globally
; M -> Meta, C -> Control, G -> global (and movement mode map)
; second symbol passed to M or C is the shift-command
; M> sets bindings on global and movement-mode maps

(defvar movement-minor-mode-map (make-sparse-keymap))

(define-minor-mode movement-minor-mode
  "turn-on,   modeline,   keymap,  globally "
  t " >" movement-minor-mode-map :global t)

(defun G (key command &optional movement)
  (progn ()
    (if movement
        (define-key movement-minor-mode-map key command))
    (global-set-key key command)))

(defmacro C (key command &optional shift-command movement)
  `(progn
     (G (kbd ,(format "C-%s" key)) ,command ,movement)
     (if ,shift-command
         (G (kbd ,(format "C-%s" (upcase (format "%s" key)))) ,shift-command ,movement))))

(defmacro M (key command &optional shift-command movement)
 `(progn
    (G (kbd ,(format "M-%s" key)) ,command ,movement)
    (if ,shift-command
        (G (kbd ,(format "M-%s" (upcase (format "%s" key)))) ,shift-command ,movement))))

(defmacro M> (key command &optional shift-command)
  `(M ,key ,command ,shift-command 'movement))

(defmacro C> (key command &optional shift-command)
  `(C ,key ,command ,shift-command 'movement))


;; M Right Hand (movement)
;dhtns-
(M> t 'next-line 'scroll-up)
(M> h 'backward-char 'beginning-of-line)
(M> n 'forward-char 'end-of-line)
(M> s 'ace-jump-mode 'isearch-forward)                    ;new
(M> - 'comment-dwim)                                      ;timid
(M  d 'nil )                                              ;unsure
;bmwvz
(M> b 'ido-switch-buffer)
(M> m 'previous-buffer)
(M> w 'next-buffer)
(M> v 'eproject-ibuffer 'ibuffer)       ;new
(M> z 'isearch-backward)
;fgcrl/=\
(M> g 'subword-backward 'beginning-of-line)
(M> c 'previous-line 'scroll-down)
(M> r 'subword-forward 'end-of-line)
(M> l 'recenter-top-bottom)             ;timid
(M> = 'count-words-region)
;67890[]
(M> 0 'delete-window)


; M Left Hand (editing)
;iueoa
(M i   'kill-line)                      ;timid
(M u   'delete-forward-char)
(M e   'delete-backward-char 'subword-backward-kill)
(M> o   'ido-switch-buffer)              ;muscle conflicts with M-a
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
;; (M y   'yank-pop)        ;default
(M p   'subword-kill)
(M "." 'subword-backward-kill)
;; (M "'" 'ido-switch-buffer-other-window) ;timid
(M "'" 'speedbar)
(M "'" 'speedbar)

;54321`
(M 5 'query-replace) (M % 'query-replace-regexp)
(M 4 'split-window-horizontally)(M $ 'split-window-vertically)
(M 3 'delete-other-windows)
(M "`" 'speedbar-get-focus) ;; new
(M <f5> 'flyspell-correct-word-before-point)
(M <f6> 'whitespace-cleanup)
(M <f7> 'pianobar)
(M <f9> 'flymake-display-err-menu-for-current-line)


;--------------

;control

; right hand
(C d 'duplicate-line-or-region)
(C> h '(lambda () (interactive)(other-window -1)))
(C> t '(lambda () (interactive)(other-window  1)))
;; (C> h 'previous-multiframe-window)
;; (C> t 'next-multiframe-window)
(C n 'forward-page)
(C s 'save-buffer)
(C b 'browse-kill-ring)
(C w 'kill-this-buffer)
(C r 'comment-or-uncomment-region)

(C f 'sudo-find-file)

; the hotness
(C 7 'my-ido-find-tag)
(C 6 'my-ido-find-file-in-tag-files)
(C 5 'find-lisp-find-dired)
(C 4 'find-grep)
(C 3 'find-file-at-point-with-line)
(C 2 'find-file-in-repository)
(C 1 'rails-grep-project)


(C p 'backward-page)
(C i 'indent-for-tab-command)
(C o 'eproject-find-file 'find-file)
(C o 'ido-find-file 'ido-find-file-other-window)
(C a 'mark-whole-buffer)

(C k 'kill-whole-line)
;; (C y 'yank) ;;default

; function keys
(global-set-key (kbd "C-<f5>") 'ispell-complete-word)
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
(G (kbd "C-c li") 'org-clock-in)
(G (kbd "C-c lo") 'org-clock-out)
(G (kbd "C-c lu") 'org-clock-update-time-maybe)
(G (kbd "C-c C-x C-j") 'org-clock-goto)
(G (kbd "C-c r") 'org-capture)

(G (kbd "A-c") 'mc/edit-lines)
(G (kbd "A->") 'mc/mark-next-like-this)
(G (kbd "A-<") 'mc/mark-previous-like-this)
(G (kbd "C-c A-<") 'mc/mark-all-like-this)



;; contrib-functions
(G (kbd "C-c C-r") 'rename-file-and-buffer)


(G (kbd "H-s") 'ido-shell-buffer)
(G (kbd "H-r") 'ido-ruby-buffer)

(G (kbd "H-f") '(lambda()(interactive) (compile "env LC_ALL=C fetchmail -v  --nodetach --nosyslog")))



;; key-chord

(eval-after-load 'dired
  ;; Brash Bindings C-h C-k C-o C-t C-S-b C-n C-p M-everything
  ;; M-o dired-omit-mode
  '(progn
     (define-key dired-mode-map (kbd "C-t") `previous-multiframe-window)
     (define-key dired-mode-map (kbd "C-h") `other-window)
     (define-key dired-mode-map (kbd "M-g" ) `keyboard-quit)
     (define-key dired-mode-map "e" `dired-up-directory)
     (define-key dired-mode-map "o" `dired-display-file)
     (define-key dired-mode-map (kbd "M-o") `ido-switch-buffer-other-window)
     (define-key dired-mode-map (kbd "C-o") nil)
     (define-key dired-mode-map "k" `dired-kill-subdir)))


(eval-after-load 'ioccur
  '(progn
     (define-key ioccur-mode-map "d" `ioccur-jump-without-quit)
     (define-key ioccur-mode-map "k" `ioccur-jump-and-quit)
     (define-key ioccur-mode-map "n" `ioccur-next-line)
     (define-key ioccur-mode-map "p" `ioccur-precedent-line)
     (define-key ioccur-mode-map "N" `ioccur-scroll-down)
     (define-key ioccur-mode-map "P" `ioccur-scroll-up)))



(eval-after-load 'isearch
  '(progn
     (define-key isearch-mode-map (kbd "C-o")
       (lambda ()
         (interactive)
         (let ((case-fold-search isearch-case-fold-search))
           (ioccur (if isearch-regexp isearch-string
                    (regexp-quote isearch-string))))))))


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
(define-key minibuffer-local-map (kbd "M-.")  'subword-backward-kill)

(setq mac-option-modifier 'hyper) ;; greenfield!

;; apparently fullscreen.el provides for both systems
;; (if (string-match "apple-darwin" system-configuration)
;;     (global-set-key [f11] 'ns-toggle-fullscreen)
;;   (global-set-key [f11] 'fullscreen))
(global-set-key [f11] 'fullscreen)

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

;; needs placement:
;; extend-selection
;; org-set-tags-to
;; find-lisp-find-dired
;; find-lisp-find-dired-subdirectories
;; wl-summary-yank-saved-message
;; wl-summary-save-current-message

;; speedbar-toggle-show-all-files
