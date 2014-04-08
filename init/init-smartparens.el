(require 'smartparens-config)
;; guide key set to use H-p.
;; keybinding management, thanks oh-my-emacs
(define-key sp-keymap (kbd "H-p f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "H-p b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "H-p d") 'sp-down-sexp)
(define-key sp-keymap (kbd "H-p D") 'sp-backward-down-sexp)
(define-key sp-keymap (kbd "H-p a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "H-p e") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "H-p u") 'sp-up-sexp)
;; (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
(define-key sp-keymap (kbd "H-p U") 'sp-backward-up-sexp)
(define-key sp-keymap (kbd "H-p t") 'sp-transpose-sexp)

(define-key sp-keymap (kbd "H-p n") 'sp-next-sexp)
(define-key sp-keymap (kbd "H-p p") 'sp-previous-sexp)

(define-key sp-keymap (kbd "H-p k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "H-p w") 'sp-copy-sexp)

(define-key sp-keymap (kbd "H-p s") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "H-p r") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "H-p S") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "H-p R") 'sp-backward-barf-sexp)
(define-key sp-keymap (kbd "H-p F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "H-p B") 'sp-backward-symbol)

(define-key sp-keymap (kbd "H-p [") 'sp-select-previous-thing)
(define-key sp-keymap (kbd "H-p ]") 'sp-select-next-thing)

(define-key sp-keymap (kbd "H-p M-i") 'sp-splice-sexp)
(define-key sp-keymap (kbd "H-p <delete>") 'sp-splice-sexp-killing-forward)
(define-key sp-keymap (kbd "H-p <backspace>") 'sp-splice-sexp-killing-backward)
(define-key sp-keymap (kbd "H-p M-<backspace>") 'sp-splice-sexp-killing-around)

(define-key sp-keymap (kbd "H-p M-d") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "H-p M-b") 'sp-backward-unwrap-sexp)

(define-key sp-keymap (kbd "H-p M-t") 'sp-prefix-tag-object)
(define-key sp-keymap (kbd "H-p M-p") 'sp-prefix-pair-object)
(define-key sp-keymap (kbd "H-p M-c") 'sp-convolute-sexp)
(define-key sp-keymap (kbd "H-p M-a") 'sp-absorb-sexp)
(define-key sp-keymap (kbd "H-p M-e") 'sp-emit-sexp)
(define-key sp-keymap (kbd "H-p M-p") 'sp-add-to-previous-sexp)
(define-key sp-keymap (kbd "H-p M-n") 'sp-add-to-next-sexp)
(define-key sp-keymap (kbd "H-p M-j") 'sp-join-sexp)
(define-key sp-keymap (kbd "H-p H-p") 'sp-split-sexp)
(define-key sp-keymap (kbd "H-p M-r") 'sp-raise-sexp)

(smartparens-global-mode t)
;; ensure (autopair-global-mode -1)
