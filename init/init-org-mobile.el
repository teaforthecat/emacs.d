
;; (setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(add-to-list 'kill-emacs-hook 'org-mobile-push)
(add-hook 'after-init-hook 'org-mobile-pull)
