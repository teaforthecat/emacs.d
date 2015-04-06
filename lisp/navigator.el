(require 'bind-key)

;; joystick <^>v  hcnt (jkli)
(bind-key "M-h" 'backward-char)
(bind-key "M-c" 'previous-line)
(bind-key "M-n" 'forward-char)
(bind-key "M-t" 'next-line)
(bind-key "M-r" 'forward-word)
(bind-key "M-g" 'backward-word)


;; copy - paste - CUA for dvorak using querty's zxcv keys
(bind-key "M-j" 'copy-region-as-kill)
(bind-key "M-k" 'clipboard-yank)
(bind-key "M-;" 'undo-tree-undo)
(bind-key "M-:" 'undo-tree-redo)
(bind-key "s-;" 'undo-tree-visualize)


;; Editing
(bind-key "M-u" 'delete-forward-char)
(bind-key "M-e" 'delete-backward-char)
(bind-key "M-U" 'kill-word)
(bind-key "M-E" 'backward-kill-word)
(bind-key "M-i" 'kill-sexp)


;; Navigate buffer and file
(bind-key  "M-T" 'scroll-up)
(bind-key "M-C" 'scroll-down)
(bind-key "M-l" 'recenter-top-bottom)


;; Utilities
(bind-key "M-SPC" 'er/expand-region)
(bind-key "M-d"   'kill-whole-line)
(bind-key "C-d"   'duplicate-line-or-region)
(bind-key "C-c -" 'goto-line)
(bind-key "M-a"   'align-regexp)
(bind-key "M-~"   'make-frame)
(bind-key "M-`"   'other-frame)


;; Built-ins
(bind-key "k"   'dired-kill-subdir dired-mode-map)
(bind-key "TAB" 'dired-hide-subdir dired-mode-map)
(bind-key "e"   'dired-up-directory dired-mode-map)
(bind-key "o"   'dired-display-file dired-mode-map)


;; Notes:

;; Super (aka "s")
;; <fn> = super unless or the "keypad" region
;; <fn> gcrhtnmwv -> calculator keys! (mac only?)
;; unfortunately the use of dvorak will rule out some built-in keybindings because
;; they will resolve to <kp> numbers first



;; query-replace-regexp C-M-%
;; use \(...\) and ...\1... to wrap a string
;; use reg     and \,(sexp \&) to call a function on the whole match
;; use re\(g\) and \,(sexp \1) to call a function on a numbered match


;; Interesting functions
;; dabbbrev-expand M-/
;; shrink-window-if-larger-than-buffer C-x -
;; center-line M-o M-s

;; Internationalization C-x 8



;; TOOD: consider cua mode


(provide 'navigator)
