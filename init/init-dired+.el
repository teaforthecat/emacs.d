(require 'dired-x) ;;dired-omit-mode exists here in a built-in

;; use default (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")

(setq dired-omit-extensions (append '("DS_Store") dired-omit-extensions))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(put 'dired-find-alternate-file 'disabled nil)

(setq dired-listing-switches "-hal")
