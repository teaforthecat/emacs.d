(require 's)
;(require 'cl-lib) ;;for union
(require 'memoize) ;;for union
(require 'my-functions) ; for spawn-shell

(defun ct/read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (if (file-exists-p filePath)
        (progn
          (insert-file-contents-literally filePath)
          (split-string (buffer-string) "\n" t)))))

;; the fastest way to get data to a file
(defun ct/write-lines (str filepath)
  (write-region str nil filepath))

(defun ct/remote-shell (use-sudo host)
  (let ((enable-recursive-minibuffers t))
    (let* ((remote-buffer-name (format "*%s%s*"
                                       (if use-sudo "root@" "" )
                                       (s-chop-suffix ".gdi" host)))
           (default-directory (format "/%s:%s:"
                                      (if use-sudo "sudo" "ssh" )
                                      host)))
      (dired default-directory)
      (spawn-shell remote-buffer-name))))

;; only need to read once for yesterday's history,
;; will loose host-history over 30 hosts
(defvar ct/remote-hosts-history-file "~/.emacs.d/tmp/my-read-hosts-history")
(defvar ct/remote-hosts-history (or (ct/read-lines ct/remote-hosts-history-file) ()))
(defvar ct/remote-hosts-history-max 30)

(defmemoize ct/remote-host-inventory-load ()
  (s-lines (shell-command-to-string
            "cat ~/.dsh/group/* | uniq")))

(defun ct/remote-hosts-inventory ()
  "must add history to inventory or the history won't be available in the list
   - and make sure history comes first"
  (let* ((hosts (ct/remote-host-inventory-load)))
    (union ct/remote-hosts-history (append ct/remote-hosts-history hosts))))


(defun ct/remote-add-to-history (host)
  (add-to-history 'ct/remote-hosts-history host ct/remote-hosts-history-max)
  (ct/write-lines (s-join "\n" ct/remote-hosts-history)
                  ct/remote-hosts-history-file))

(defun ct/completing-hosts ()
  (let ((enable-recursive-minibuffers t))
    (ido-completing-read  "host: "
                          (ct/remote-hosts-inventory) nil nil nil
                          'ct/remote-hosts-history
                          (car ct/remote-hosts-history))))

(defun goto-remote-host (use-sudo)
  (interactive "P")
  (let ((enable-recursive-minibuffers t)
        (host (ct/completing-hosts)))
    (ct/remote-shell use-sudo host)
    (ct/remote-add-to-history host)))

(defun ct/cd-remote (proto path &optional form)
  "get a connection to another host and return the tramp file name(default-directory)
optionally evaluate code in a different place"
  (eval `(save-excursion
           (eshell)
           (goto-char (point-max))
           (insert "cd /" proto ":"
                   (ct/completing-hosts)
                   ":" path)
           (eshell-send-input)
           ,form
           default-directory)))

(defun ct/cdsudo (&optional proto path)
  "use eshell because that is the only way so far to get a 'Passcode:' prompt for two factor auth"
  (interactive)
  (window-configuration-to-register :previous-remote)
  (let* ((_proto (or proto "ssh"))
         (_path (or path "/etc/"))
         (dired-listing-switches "-halt")
         (default-directory (ct/cd-remote _proto _path )))
    (dired default-directory)
    (delete-other-windows)
    (split-window)
    (other-window 1)
    (spawn-shell default-directory)
    (other-window -1)))

(defun ct/goto-remote-previous ()
  (interactive)
  (jump-to-register :previous-remote))


;; TODO remove enable-recursive-minibuffers
(provide 'remote-hosts)
