
(defun dired-ediff-marked-files ()
  "Run ediff on marked ediff files."
  (interactive)
  (set 'marked-files (dired-get-marked-files))
  (when (= (safe-length marked-files) 2)
    (ediff-files (nth 0 marked-files) (nth 1 marked-files)))
  
  (when (= (safe-length marked-files) 3)
    (ediff3 (buffer-file-name (nth 0 marked-files))
            (buffer-file-name (nth 1 marked-files)) 
            (buffer-file-name (nth 2 marked-files)))))


(defun cycle-buffer-by-mode (p-mode)
  "Cycle buffers by mode name"
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (buffer-live-p buffer)
        (if (string-match p-mode mode-name) ;(regexp-quote p-mode)
            (setq switch2buffer buffer)))))
  (when (boundp 'switch2buffer)
    (switch-to-buffer switch2buffer)))

(defvar my-ediff-bwin-config nil "Window configuration before ediff.")
(defcustom my-ediff-bwin-reg ?b
  "*Register to be set up to hold `my-ediff-bwin-config'
    configuration.")

(defun my-ediff-bsh ()
  "Function to be called before any buffers or window setup for
    ediff."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess)
  (window-configuration-to-register my-ediff-bwin-reg))

(defun my-ediff-aswh ()
"setup hook used to remove the `ediff-cleanup-mess' function.  It causes errors."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess))

(defun my-ediff-qh ()
  "Function to be called when ediff quits."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess)
  (ediff-cleanup-mess)
  (jump-to-register my-ediff-bwin-reg))

(add-hook 'ediff-before-setup-hook 'my-ediff-bsh)
(add-hook 'ediff-after-setup-windows-hook 'my-ediff-aswh);
(add-hook 'ediff-quit-hook 'my-ediff-qh)

