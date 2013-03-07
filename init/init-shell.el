
(add-hook 'shell-mode-hook 'dirtrack-mode)

(setq comint-buffer-maximum-size 1000)
(setq tramp-default-method "ssh")

(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

