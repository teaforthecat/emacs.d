(require 'dired-x) ;;dired-omit-mode exists here in a built-in

(setq dired-omit-files "|^\\..*|.*~$")

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(put 'dired-find-alternate-file 'disabled nil)

(setq dired-listing-switches "-Shal")
