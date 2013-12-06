;; copied from http://www.elliotglaysher.org/emacs/

;; --------------------------------------------------------------- [ erc ]
;; The emacs IRC client
(eval-after-load "erc"
  '(progn
     ;; Basic erc setup
     (setq erc-nick "teaforthecat"
           erc-autojoin-channels-alist '(("freenode.net" "#emacs"))
           erc-keywords '("teaforthecat")
           erc-format-nick-function 'erc-format-@nick
           erc-interpret-mirc-color t
           erc-button-buttonize-nicks nil
           erc-user-full-name user-full-name
           erc-track-position-in-mode-line 'after-modes)

     (erc-scrolltobottom-enable)
     (erc-spelling-mode t)
     (erc-netsplit-mode t)

     ;; Lots of default messages say the whole hostname of a user. Instead, use
     ;; short forms.
     (erc-define-catalog-entry 'english 'JOIN
                               "%n has joined channel %c")
     (erc-define-catalog-entry 'english 'NICK
                               "%n is now known as %N")
     (erc-define-catalog-entry 'english 'MODE
                               "%n has change mode for %t to %m")
     (erc-define-catalog-entry 'english 'QUIT
                               "%n has quit: %r")
     (erc-define-catalog-entry 'english 'TOPIC
                               "%n has set the topic for %c: \"%T\"")

;     (require 'erc-goodies)

     ;; Don't spam me bro
     (setq erc-hide-list '("JOIN" "PART" "QUIT"))

     ;; Don't spam my modeline.
     ;; (require 'erc-track)
     ;; (erc-track-mode 1)
     ;; (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
     ;;                                 "324" "329" "332" "333" "353" "477"))

     ;; Nickserv
;     (load "~/.emacs.d/private/erc-auth")
;     (setq erc-prompt-for-nickserv-password nil)
;     (require 'erc-services)
;     (erc-services-mode 1)

     ;; Truncate buffers so they don't hog core.
     (setq erc-max-buffer-size 1000)
     (defvar erc-insert-post-hook)
     (add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
     (setq erc-truncate-buffer-on-save t)))

(defadvice erc-cmd-IGNORE (after ignore-replys-to (&optional user) activate)
  "After every ignore, copy the list `erc-ignore-list' to
`erc-ignore-reply-list'. When I ignore someone, I want them *gone*."
  (erc-with-server-buffer (setq erc-ignore-reply-list erc-ignore-list)))

(defadvice erc-cmd-UNIGNORE (after ignore-replys-to (&optional user) activate)
  "In case of mistakes made with /ignore."
  (erc-with-server-buffer (setq erc-ignore-reply-list erc-ignore-list)))

(defun erc-cmd-OPME ()
  "tell chanserv to op me (from: http://paste.lisp.org/display/97466)"
  (interactive)
  (erc-message "PRIVMSG"
	       (format "chanserv op %s %s"
		       (erc-default-target)
		       (erc-current-nick)) nil))

(defun erc-cmd-DEOPME ()
  "deop myself (from: http://paste.lisp.org/display/97466)"
  (interactive)
  (erc-cmd-DEOP (format "%s" (erc-current-nick))))

