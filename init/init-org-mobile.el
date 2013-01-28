


(setq org-mobile-agendas 'default) ;;  the weekly agenda and the global TODO list
;; (setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-force-id-on-agenda-items nil) ;;gamble with org paths
(setq org-mobile-directory "/volumes/webdav/ownCloud/org")
(setq org-mobile-directory "/ssh:cthompson@owncloud.spyrabbit.net:org")
(setq org-mobile-inbox-for-pull "~/org/refile.org")

;;(setq org-mobile-files )

(add-to-list 'kill-emacs-hook 'org-mobile-push)
(add-hook 'after-init-hook 'org-mobile-pull)
