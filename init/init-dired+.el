
(setq dired-omit-files "^\\..*|.*~$")

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(put 'dired-find-alternate-file 'disabled nil)

