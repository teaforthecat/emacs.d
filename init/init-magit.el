
;; https://github.com/waymondo/hemacs/blob/master/hemacs-git.el
;; full screen magit-status

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

;; whitespace toggle
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))


(eval-after-load 'magit
  '(progn
     (define-key magit-mode-map (kbd "M-3") 'delete-other-windows)
     (define-key magit-mode-map (kbd "q") 'magit-quit-session)
     (define-key magit-mode-map (kbd "W") 'magit-toggle-whitespace)
     (ignore-errors ;;may already be loaded
       (magit-key-mode-insert-action
        'logging "p" "Paths" 'ofv-magit-log-for-paths)) ))

(defun ofv-magit-log-for-paths ()
  (interactive)
  (let ((paths (read-string "Files or directories: ")))
    (apply 'magit-log nil "--" (split-string paths))))
