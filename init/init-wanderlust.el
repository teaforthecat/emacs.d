(require 'w3m)
(require 'mime-w3m)
(require 'elmo-search)


(elmo-search-register-engine
    'mu 'local-file
    :prog "/usr/local/bin/mu"
    :args '("find" pattern "--fields" "l" "--sortfield=date") :charset 'utf-8)

(setq elmo-search-default-engine 'mu)
;; for when you type "g" in folder or summary.
(setq wl-default-spec "[")



(defadvice wl (around wl-fullscreen activate)
  (window-configuration-to-register :wl-fullscreen)
  ad-do-it
  (delete-other-windows))

(defadvice wl-draft (around wl-fullscreen activate)
  (window-configuration-to-register :wl-fullscreen)
  ad-do-it
  (delete-other-windows))

(defadvice wl-draft-kill (after wl-fullscreen activate)
  (jump-to-register :wl-fullscreen))

(defun wl-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (if current-prefix-arg 
      (wl-exit)
    (bury-buffer))
  (jump-to-register :wl-fullscreen))

(eval-after-load 'wl
  '(progn
     (define-key wl-folder-mode-map (kbd "q") 'wl-quit-session)))


(load-file "~/.emacs.d/contrib/dmj-html-message.el")

;; (setq elmo-imap4-debug t)
;; (setq send-mail-function 'smtpmail-send-it)

(add-hook 'wl-draft-mode-hook 'flyspell-mode-on)

;; wrap lines
(setq message-truncate-lines nil
      wl-draft-truncate-lines nil
      wl-message-truncate-lines nil)

;;look into
;;wl-summary-auto-sync-marks

;;text/calendar
(defun import-mime-text-calendar (entity &optional situation)
  "import entity to diary"
  ;; a little more work than neccessary here since 
  ;; icalendar-import-buffer uses current-buffer,
  ;; which is a different buffer than the with-temp-buffer one
  (save-excursion 
    (let ((temp-file-name (make-temp-file "/tmp/")))
      (mime-write-entity-content entity temp-file-name)
      (icalendar-import-file temp-file-name diary-file)
      (kill-buffer (find-buffer-visiting temp-file-name))
      (delete-file temp-file-name))))



;; Invert behaviour of with and without argument replies.
;; just the author
(setq wl-draft-reply-without-argument-list
      '(("Reply-To"      ("Reply-To") nil nil)
        ("Mail-Reply-To" ("Mail-Reply-To") nil nil)
        ("From"          ("From") nil nil)))

;;mime-view

(add-hook 'wl-init-hook
  '(lambda ()
    (ctree-set-calist-strictly
     'mime-acting-condition
     '((mode . "play")
       (type . text)(subtype . calendar)
       (method . import-mime-text-calendar)))))


(setq wl-draft-folder   ".drafts"
      wl-trash-folder   ".trash"
      wl-fcc            ".sent")

(setq wl-fcc-force-as-read t)
(setq wl-draft-always-delete-myself t)

;;(setq wl-biff-mail-image '(image :type xpm :file "/usr/local/Cellar/emacs/24.3/share/emacs/24.3/etc/images/newsticker/mark-immortal.xpm" :ascent center))

;; biff updates
;; default (setq wl-biff-check-interval 40)
(setq wl-biff-check-folder-list '(".GD/INBOX"))

(add-hook 'wl-biff-notify-hook '(lambda ()(message "NEW MAIL")))

;; Set mail-icon to be shown universally in the modeline.
(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))

;; Fields
(setq wl-draft-fields '("To:" "Cc:" "From:" "Reply-To:"))
(setq wl-message-ignored-field-list '(".*"))
(setq wl-message-visible-field-list 
      '("^To" "^Subject" "^From" "^Date" "^Cc")
      wl-message-sort-field-list
      '("^From"
        "^Subject"
        "^To"
        "^Cc"))


;; 

;; folders
(setq wl-folder-check-async  t )
(setq wl-summary-auto-refile-skip-marks nil)
(setq wl-refile-rule-alist
      '(("From"         
         ("Cron Daemon"     . ".GD/cron")
         ("jenkins"         . ".GD/jenkins")
         ("Chatter"         . ".GD/chatter")
         ("nagios"          . ".GD/nagios")
         ("Restart.Script"  . ".GD/ops"))
        (("To" "Cc")
         ("chris.thompson@govdelivery" . 
          ("From" ("\\(.*\\) <.*@govdelivery.com>" .
                     ".GD/from/\\1"))))))


;;also consider:
;; `display-time-mail-face'
;; `display-time-mail-file'
;; `display-time-mail-directory'
