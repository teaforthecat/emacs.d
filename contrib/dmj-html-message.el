;; http://www.emacswiki.org/emacs/WlFaq
(defun dmj/wl-send-html-message ()
  "Send message as html message.
  Convert body of message to html using
  `org-export-region-as-html'."
  (require 'org)
  (save-excursion
    (let (beg end html text)
      (goto-char (point-min))
      (re-search-forward "^--text follows this line--$")
      ;; move to beginning of next line
      (beginning-of-line 2)
      (setq beg (point))
      (setq end (point-max))
      ;; grab body
      (setq text (buffer-substring-no-properties beg end))
      
      (with-temp-buffer
        (insert text)
        (mark-whole-buffer)
        (org-html-convert-region-to-html)
        (setq html (buffer-string)))

      (delete-region beg end)
      (insert
       (concat
	"--" "<<alternative>>-{\n"
	"--" "[[text/plain]]\n" text "\n\n"
        "--" "[[text/html]]\n"  html "\n\n"
	"--" "}-<<alternative>>\n")))))

(setq dmj/wl-send-html-message-toggled-p )
(defun dmj/wl-send-html-message-toggle ()
  "Toggle sending of html message."
  (interactive)
  (setq dmj/wl-send-html-message-toggled-p
        (if dmj/wl-send-html-message-toggled-p
            nil "HTML"))
  (message "Sending html message toggled %s"
           (if dmj/wl-send-html-message-toggled-p
               "on" "off")))

(defun dmj/wl-send-html-message-draft-init ()
  "Create buffer local settings for maybe sending html message."
  (unless (boundp 'dmj/wl-send-html-message-toggled-p)
    (setq dmj/wl-send-html-message-toggled-p nil))
  (make-variable-buffer-local 'dmj/wl-send-html-message-toggled-p)
  (add-to-list 'global-mode-string
               '(:eval (if (eq major-mode 'wl-draft-mode)
                           dmj/wl-send-html-message-toggled-p))))

(defun dmj/wl-send-html-message-maybe ()
  "Maybe send this message as html message.

If buffer local variable `dmj/wl-send-html-message-toggled-p' is
non-nil, add `dmj/wl-send-html-message' to
`mime-edit-translate-hook'."
  (if dmj/wl-send-html-message-toggled-p
      (add-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)
    (remove-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)))

(add-hook 'wl-draft-reedit-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-mail-setup-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-draft-send-hook 'dmj/wl-send-html-message-maybe)
