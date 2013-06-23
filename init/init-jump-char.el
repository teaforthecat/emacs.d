(require 'jump-char)

(setq mac-function-modifier 'hyper) ;; fn as hyper

(defun add-hyper-char-to-hyper-jump-char (c)
  (define-key global-map
    (read-kbd-macro (concat "H-" (string c)))
    `(lambda ()
       (interactive)
       (setq jump-char-initial-char (make-string 1 ,c))
       (jump-char-search-forward jump-char-initial-char)
       )))

(loop for c from ?0 to ?9 do (add-hyper-char-to-hyper-jump-char c))
(loop for c from ?A to ?Z do (add-hyper-char-to-hyper-jump-char c))
(loop for c from ?a to ?z do (add-hyper-char-to-hyper-jump-char c))

