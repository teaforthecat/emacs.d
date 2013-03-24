(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(setq compilation-ask-about-save nil)
(setq compilation-save-buffers-predicate '(lambda () nil))
(fset 'yes-or-no-p 'y-or-n-p)

(setq flymake-gui-warnings-enabled nil)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; from magnars
;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)
;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; Show keystrokes in progress
(setq echo-keystrokes 0.1)
;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)
;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)
;; Transparently open compressed files
(auto-compression-mode t)

(global-visual-line-mode t)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

(show-paren-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Don't break lines for me, please
(setq-default truncate-lines t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)


(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (setq ns-function-modifier 'hyper))

(setq temporary-file-directory "~/.emacs.d/tmp/")

(setq require-final-newline  t)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

(provide 'reset)
