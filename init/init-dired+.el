(require 'dired-x) ;;dired-omit-mode exists here in a built-in
;; use xargs instead of exec for speed
(setq find-ls-option '("-print0 | xargs -0 ls -ldH" . "-ldH"))


;; use default (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")

(setq dired-omit-extensions (append '("DS_Store"
                                      "com.apple.timemachine.supported") dired-omit-extensions))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(put 'dired-find-alternate-file 'disabled nil)

(setq dired-listing-switches "-hal")


(defadvice dired-kill-subdir (after kill-dired-buffer-as-well
                                    last (&optional REMEMBER-MARKS) activate protect)
  (if (= (point-min) (point))
      (kill-buffer)))


