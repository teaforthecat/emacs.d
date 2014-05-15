(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)

(defadvice ediff-files (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-revision (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-buffers (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-windows-wordwise (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-quit (after ediff-off-fullscreen activate)
  (jump-to-register :ediff-fullscreen))


;; magit
(defadvice magit-ediff (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))


(defun ct/ediff-revision ()
  (interactive)
  (ediff-revision (buffer-file-name)))
