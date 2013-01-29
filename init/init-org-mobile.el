


(setq org-mobile-force-id-on-agenda-items nil) ;;gamble with org paths

;; (setq org-mobile-directory "/volumes/webdav/ownCloud/org") ;:slow
;; (setq org-mobile-directory "/ssh:cthompson@owncloud.spyrabbit.net:org") ;:slow

(setq org-mobile-inbox-for-pull "~/Dropbox/org/refile.org")
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;;(setq org-mobile-files )

(add-to-list 'kill-emacs-hook 'org-mobile-push)
(add-hook 'after-init-hook 'org-mobile-pull)
