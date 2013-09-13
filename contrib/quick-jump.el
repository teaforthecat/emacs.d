;; http://stackoverflow.com/a/17500384/714357
(require 'bookmark)
(require 'ido)

(defvar bookmark-ido-quick-jump-map (copy-keymap minibuffer-local-map)
  "Keymap for `bookmark-ido-quick-jump'.

Every time `ido-completing-read' is called it re-initializes
`ido-common-completion-map' and sets its parent to be `minibuffer-local-map'.

In `bookmark-ido-quick-jump' we provide this modified copy as a replacement
parent.")

;; this is the juice:
;; (define-key bookmark-ido-quick-jump-map
;;   [remap self-insert-command] 'my-self-insert-and-ido-complete)

(defun bookmark-ido-quick-jump ()
  "Jump to selected bookmark, using auto-completion and auto-acceptance."
  (interactive)
  (bookmark-maybe-load-default-file)
  (let ((minibuffer-local-map bookmark-ido-quick-jump-map)
        (ido-enable-prefix t))
    (bookmark-jump
     (ido-completing-read "Jump to bookmark: " 
                          (loop for b in bookmark-alist collect (car b))))))

(defun my-self-insert-and-ido-complete (n)
  "Insert the character, then attempt to complete the current string,
automatically exiting when only one option remains."
  (interactive "p")
  (self-insert-command n)
  ;; ido uses buffer-local pre- and post-command hooks, so we need to
  ;; co-operate with those. We append our post-command function so that
  ;; it executes after ido has finished processing our self-insert.
  (add-hook 'post-command-hook
            'my-self-insert-and-ido-complete-post-command t t))

(defun my-self-insert-and-ido-complete-post-command ()
  (remove-hook 'post-command-hook
               'my-self-insert-and-ido-complete-post-command t)
  ;; Now that ido has finished its normal processing for the current
  ;; command, we simulate a subsequent `ido-complete' command.
  (ido-tidy) ;; pre-command-hook
  (ido-complete)
  (ido-exhibit)) ;; post-command-hook

