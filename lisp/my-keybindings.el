; sets movement-minor-mode globally
; M -> Meta, C -> Control, G -> global (and movement mode map)
; second symbol passed to M or C is the shift-command
; M> sets bindings on global and movement-mode maps

(defvar movement-minor-mode-map (make-sparse-keymap))

(define-minor-mode movement-minor-mode
  "set of keys for basic navigation which should not be stomped on"
  t " >" movement-minor-mode-map :global t)

(defun G (key command &optional movement)
  "global-set-key and maybe movement too"
  (progn ()
    (if movement
        (define-key movement-minor-mode-map key command))
    (global-set-key key command)))

(defmacro C (key command &optional shift-command movement)
  "set Meta-KEY lower to COMMAND then upper to SHIFT_COMMAND. maybe send both to movement-mode-map"
  `(progn
     (G (kbd ,(format "C-%s" key)) ,command ,movement)
     (if ,shift-command
         (G (kbd ,(format "C-%s" (upcase (format "%s" key)))) ,shift-command ,movement))))

(defmacro M (key command &optional shift-command movement)
  "set Meta-KEY lower to COMMAND then upper to SHIFT_COMMAND. maybe send both to movement-mode-map"
  `(progn
     (G (kbd ,(format "M-%s" key)) ,command ,movement)
     (if ,shift-command
         (G (kbd ,(format "M-%s" (upcase (format "%s" key)))) ,shift-command ,movement))))

(defmacro H (key command &optional shift-command movement)
  "set Meta-KEY lower to COMMAND then upper to SHIFT_COMMAND. maybe send both to movement-mode-map"
  `(progn
     (G (kbd ,(format "H-%s" key)) ,command ,movement)
     (if ,shift-command
         (G (kbd ,(format "H-%s" (upcase (format "%s" key)))) ,shift-command ,movement))))

(defmacro H> (key command &optional shift-command)
  `(H ,key ,command ,shift-command 'movement))

(defmacro M> (key command &optional shift-command)
  `(M ,key ,command ,shift-command 'movement))

(defmacro C> (key command &optional shift-command)
  `(C ,key ,command ,shift-command 'movement))



;; M Right Hand (movement)
;dhtns-
(M> t 'next-line 'scroll-up)
(M> h 'backward-char 'beginning-of-line)
(M> n 'forward-char 'end-of-line)
(M> s 'ace-jump-mode 'isearch-forward)
(M> - 'comment-dwim)                                      ;timid
(M  d 'kill-whole-line )                                              ;unsure
;bmwvz
(M> b  'bookmark-ido-quick-jump)
(M> m 'previous-buffer)
(M> w 'next-buffer)
(M> v 'er/expand-region 'ibuffer)
;;(M> z 'isearch-backward) ;;timid -could use M-S then C-r
;fgcrl/=\
(M> g 'backward-word 'backward-sentence)
(M> c 'previous-line 'scroll-down)
(M> r 'forward-word 'forward-sentence)
(M> l 'recenter-top-bottom)
;;(M> = 'count-words-region)         ;not used very much
;67890[]
;(M> 0 'delete-window) use C-x 0 instead


; M Left Hand (editing)
;iueoa
(M i   'kill-line)
(M u   'delete-forward-char)
(M e   'delete-backward-char 'subword-backward-kill)
(M> o   'ido-switch-buffer)              ;muscle conflicts with M-a
(M a   'execute-extended-command)       ;dup of M-x but easier to hit
;xkjq;
(M x 'execute-extended-command)         ;timid (why?)
(M k   'clipboard-yank)              ;; keyboard "v" paste
(M j   'clipboard-kill-ring-save)    ;; keyboard "c" copy
(M q   'kill-region)                 ;; keyboard "x" cut
(M "SPC" 'compile)                   ;; enter a command
;yp.,'
(M ";" 'undo-tree-undo)              ;; keyboard "z" undo
(M ":" 'undo-tree-redo)
;; (M y   'yank-pop)        ;default
(M p   'subword-kill)                ;; love this
(M> "." 'subword-backward-kill)      ;; love this
;; (M "'" 'ido-switch-buffer-other-window) ;timid
;; (M "'" 'sr-speedbar-toggle)
(M> \' 'er/mark-outside-quotes)      ;; does this work?
(M> \" 'er/mark-inside-quotes)       ;; does this work? maybe just expand region

;54321`
(M 5 'query-replace) (M % 'query-replace-regexp)
(M $ 'split-window-horizontally)(M 4 'split-window-vertically)
(M 3 'delete-other-windows)
;;(M "`" 'speedbar-get-focus) ;;
(M <f5> 'flyspell-auto-correct-previous-word)
(M <f6> 'whitespace-cleanup)
(M <f7> 'pianobar)
;;(M <f9> 'flymake-display-err-menu-for-current-line)
;; OMG look at dabbrev-expand M-/

;--------------

;control
; right hand
(C d 'duplicate-line-or-region) ;; don't want this in minibuffer
(C> h (lambdo (other-window -1)))
;;(C> t '(lambda () (interactive)(other-window  1)))
(C> t 'ace-window)

(G (kbd "C-n") 'forward-paragraph) ;;duplicate of M-R see: C-p backward-paragraph
(C s 'save-buffer)
(C b 'browse-kill-ring)
(C w 'kill-this-buffer)
(C r 'comment-or-uncomment-region)
;; l
;; / =
(C = 'er/expand-region) ;;needs practice
;; \
(C f 'sudo-find-file)

; the hotness
; finders
(C 8 (lambdo (ioccur (unless current-prefix-arg (thing-at-point 'symbol)))))
(C> 7 'idomenu) (C> * 'my-ido-find-tag) ;;duplicate of C-1
(C> 6 'my-ido-find-file-in-tag-files)
(C> 5 'find-lisp-find-dired)
(C> 4 'ack-line)
(C> 3 'find-file-at-point-with-line) ;;TODO: add sudo find file with shift
(C> 2 'ftf-find-file)
(if (display-graphic-p)
    (C> @ 'ftf-grepsource)
  (C> @ 'set-mark-command));; weird. C-<space> is inserting C-@ in mac terminal

(C> 1 'idomenu)(C> ! 'find-tag) ;; TODO: duplicate of C-7

(C ~ (lambdo (let ((default-directory "~")) (ido-find-file)))) ;;needs practice

(C p 'backward-paragraph) ;;duplicate of M-G above
(C i 'indent-for-tab-command) ;;hmmmm
;(C o 'eproject-find-file 'find-file)
(C o 'ido-find-file ) ;; maybe add sudo-find-file with shift
;(C O 'ido-find-file-other-window ) ;; why (translated from C-S-o) ?
(C a 'mark-whole-buffer)

(C k 'kill-whole-line)  ;;duplicate of M-D above
;; (C y 'yank) ;;default

; function keys
(global-set-key (kbd "C-<f5>") 'ispell-complete-word) ;;paired with M-<f5>
(global-set-key (kbd "<f6>") 'whitespace-mode)
(global-set-key (kbd "<f5>") 'flyspell-mode)
;;(global-set-key (kbd "<f9>") 'flymake-mode) use flycheck instead

(global-set-key (kbd "<f7>") 'pianobar)


;; C-x-* Initialize apps
(G (kbd "C-x g") 'magit-status)
(G (kbd "C-x f") 'ftf-grepsource) ;;duplicate of C-@
(G (kbd "C-x -") 'goto-line)
(G (kbd "C-x k") 'kill-this-buffer)
(G (kbd "C-c li") 'org-clock-in)
(G (kbd "C-c lo") 'org-clock-out)
(G (kbd "C-c lu") 'org-clock-update-time-maybe)
(G (kbd "C-c C-x C-j") 'org-clock-goto)
(G (kbd "C-c r") 'org-capture)

;; contrib-functions
(G (kbd "C-c C-r") 'rename-file-and-buffer) ;;TODO: check for file existance then just rename buffer

(G (kbd "<backtab>") 'zencoding-expand-yas) ;;shift-<tab> oh my this is specialized, maybe it doesn't belong here

;; HYPER
;; multiple cursors
(H c 'mc/edit-lines)
(H > 'mc/mark-next-like-this)
(H < 'mc/mark-previous-like-this)
(G (kbd "C-c H-<") 'mc/mark-all-like-this)

(H SPC 'er/expand-region) ;;hyperspace
(M RET 'align)

(H s 'ido-shell-buffer)
(H r 'ido-ruby-buffer)
(H d 'ido-dired-buffer)
;(H d 'dictionary-lookup-definition 'flyspell-auto-correct-word)
(H f 'run-fetchmail 'run-fetchmail-verbose)

(H 8 'window-configuration-to-register)
(H 0 'register-to-point)
(H \' 'er/expand-region ) ;;duplicate of M-=


;; (defun toggle-subdir-and-stay ()
;;   (interactive)
;;   (save-excursion
;;     (dired-hide-subdir)))

(eval-after-load 'dired
  ;; Brash Bindings C-h C-k C-o C-t C-S-b C-n C-p M-everything
  ;; M-o dired-omit-mode
  '(progn
     (define-key dired-mode-map (kbd "TAB") `dired-hide-subdir)
     (define-key dired-mode-map (kbd "C-t") `previous-multiframe-window)
     (define-key dired-mode-map (kbd "C-h") `other-window)
     (define-key dired-mode-map (kbd "M-g" ) `keyboard-quit)
     (define-key dired-mode-map (kbd "C-d" ) `shell-here-now)
     (define-key dired-mode-map "e" `dired-up-directory)
     (define-key dired-mode-map "o" `dired-display-file)
     (define-key dired-mode-map (kbd "M-o") `ido-switch-buffer-other-window)
     (define-key dired-mode-map (kbd "M-$") `split-window-horizontally)
     (define-key dired-mode-map (kbd "C-o") nil)
     (define-key dired-mode-map "k" `dired-kill-subdir)))

(eval-after-load 'org
  '(progn
     (define-key org-mode-map (kbd "M-e") `delete-backward-char)
     (define-key org-mode-map (kbd "M-a") `execute-extended-command)
     ))

(eval-after-load 'ioccur
  ;; WARNING: characters are hard coded in fn: ioccur-read-search-input
  ;; this mode conflicts with global movement-minor-mode
  ;; see (describe-function 'ioccur)
  ;; C-y is yank via (car kill-ring)
  ;; C-w is yank stuff at point
  ;; C-a and C-e bol/eol
  ;; TAB and shift-TAB for history
  '(progn
     (define-key ioccur-mode-map "d" `ioccur-jump-without-quit)
     (define-key ioccur-mode-map "n" `ioccur-next-line)
     (define-key ioccur-mode-map "p" `ioccur-precedent-line)
     (define-key ioccur-mode-map "N" `ioccur-scroll-down)
     (define-key ioccur-mode-map "P" `ioccur-scroll-up)))

;; NOTE: try to use ioccur-dired on marked files in dired
(setq ioccur-length-line nil)
(setq ioccur-buffer-completion-use-ido 'ido-completing-read)

(eval-after-load 'occur
  (progn
  (define-key occur-mode-map "n" 'occur-next)
  (define-key occur-mode-map "p" 'occur-prev)
  ))

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

;; (eval-after-load 'magit
;;   '(progn
;;      (define-key magit-mode-map (kbd "C-\t") 'magit-show-only-files))) ;; this is done with C--


(eval-after-load 'rspec
  '(progn
     (define-key rspec-mode-keymap (kbd "C-c v s") `rspec-verify-single)))


(eval-after-load 'shell
  ;; Brash Bindings: C-d, C-e, C-s, C-., M-RET, M-?, C-M-l, M-n, M-p, M-r
  '(progn
     (define-key shell-mode-map (kbd "M-r") 'subword-forward)
     (define-key shell-mode-map (kbd "M-n") 'forward-char)
     (define-key shell-mode-map (kbd "C-r") 'comint-history-isearch-backward)
     (define-key shell-mode-map (kbd "C-R") 'comint-history-isearch-backward-regexp)
     ;; maybe remove these unnecessary custom  key bindings:
     (define-key shell-mode-map (kbd "C-.") 'comint-previous-input)
     (define-key shell-mode-map (kbd "C-e") 'comint-next-input)
     ;; M-p is comint-previous-input so,
     (define-key shell-mode-map (kbd "M-P") 'comint-next-input)
     ))

(eval-after-load 'comint
  '(progn
     (define-key compilation-mode-map (kbd "C-p") 'compilation-previous-error)
     (define-key compilation-mode-map (kbd "C-n") 'compilation-next-error)))

(eval-after-load 'slime
  '(progn
     (define-key slime-mode-map (kbd "M-n") 'forward-char)))


(eval-after-load 'bookmark-bmenu-mode
  '(progn
     (define-key bookmark-bmenu-mode-map (kbd "i") 'bmkp-bmenu-describe-this-bookmark)
     (define-key bookmark-bmenu-mode-map (kbd "^") 'bmkp-bmenu-mark-bookmarks-tagged-regexp)
     (define-key bookmark-bmenu-mode-map (kbd "*") 'bmkp-bmenu-jump-to-marked)))


; these might be causing the minibuffer . and h weirdness                                        ;timid
;(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-and-exit)
;(define-key minibuffer-local-map (kbd "M-.")  'subword-backward-kill)

;; key-chord ;; danger
;(key-chord-define shell-mode-map "qn" 'rename-uniquely)
;(key-chord-define global-map  "_S" 'isearch-backward)

;; alias
(defalias 'vis 'visual-line-mode)
(defalias 'ini 'goto-init-for)
;(defalias 'rem 'goto-remote-host) use cds instead
(defalias 'pro 'ct/goto-project)
(defalias 'tl 'toggle-truncate-lines)
(defalias 'tc 'tramp-cleanup-all-connections)
(defalias 'tb 'tramp-cleanup-all-buffers)
(defalias 'ru 'rename-uniquely)
(defalias 'calc-clear 'calc-reset)
(defalias 'wg 'wgrep-change-to-wgrep-mode)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
(defalias 'cds (lambdo (ct/cdsudo "sudo" "/etc" )))
(defalias 'grp 'ct/goto-remote-previous)

(global-set-key (kbd "C-c C-\\" ) 'comint-quit-subjob) ;;not sure about this one

(global-set-key [f11] 'fullscreen)
(global-set-key [f12] 'org-agenda) ;;use this more
(global-set-key [f8] 'prodigy) ;; needs shell buffers
(define-key ctl-x-map (kbd "C-d") nil) ;; unset 'list-directory

(global-set-key (kbd "M-~") 'make-frame)
(global-set-key (kbd "M-`") 'other-frame)

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

;; in contrib/quick-jump.el
;; bookmark-ido-quick-jump



;; er/mark-word
;; er/mark-symbol
;; er/mark-symbol-with-prefix
;; er/mark-next-accessor
;; er/mark-method-call
;; er/mark-inside-pairs
;; er/mark-outside-pairs
;; er/mark-comment
;; er/mark-url
;; er/mark-email
;; er/mark-defun

;; try: sticky-windows

;; diary-insert-entry

;; conflicts:
;; nrepl-jump M-.
;; js-find-symbol

;; fill-paragraph
;; forward-sentence
;; backward-sentence
;; repeat is C-x z


;; copy-rectangle-as-kill C-x r M-w
;; yank-rectangle         ..........
;; rinari-find-controller
;; unset tmm-menubar
;; make-frame
;; switch-frame
;; image-mode-fit-frame
;; ace-jump-buffer
