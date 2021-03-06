(require 'dired-x) ;;dired-omit-mode exists here in a built-in
;; use xargs instead of exec for speed
(setq find-ls-option '("-print0 | xargs -0 ls -ldH" . "-ldH"))


;; use default (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")

(setq dired-omit-extensions (append '("DS_Store"
                                      "com.apple.timemachine.supported") dired-omit-extensions))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)
            (set (make-local-variable 'ido-use-filename-at-point) nil)))

(put 'dired-find-alternate-file 'disabled nil)

(setq dired-listing-switches "-hal")


(defadvice dired-kill-subdir (after kill-dired-buffer-as-well
                                    last (&optional REMEMBER-MARKS) activate protect)
  (if (= (point-min) (point))
      (kill-buffer)))


(defun dired-ediff-marked-files ()
  "Run ediff on marked ediff files."
  (interactive)
  (set 'marked-files (dired-get-marked-files))
  (when (= (safe-length marked-files) 2)
    (ediff-files (nth 0 marked-files) (nth 1 marked-files)))

  (when (= (safe-length marked-files)
           (ediff3 (nth 0 marked-files)
                   (nth 1 marked-files)
                   (nth 2 marked-files)))))
