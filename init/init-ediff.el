(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)

(defadvice ediff-files (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-revision (before ediff-on-fullscreen activate)
  (window-configuration-to-register :ediff-fullscreen))

(defadvice ediff-quit (after ediff-off-fullscreen activate)
  (jump-to-register :ediff-fullscreen))
