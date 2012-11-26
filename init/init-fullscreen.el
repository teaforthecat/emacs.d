;; https://raw.github.com/emacsmirror/emacswiki.org/master/fullscreen.el
;; is broken in emacs24
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
