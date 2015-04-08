(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "/Users/cthompson/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "9cb6358979981949d1ae9da907a5d38fb6cde1776e8956a1db150925f2dad6c1" "4dd1b115bc46c0f998e4526a3b546985ebd35685de09bc4c84297971c822750e" default)))
 '(ibuffer-saved-filter-groups
   (quote
    (("special"
      ("special"
       (name . "^*")))
     ("one-emacs-lisp-mode"
      ("one-emacs-lisp-mode"
       (used-mode . emacs-lisp-mode))))))
 '(ibuffer-saved-filters
   (quote
    (("emacs-lisp-mode"
      ((used-mode . emacs-lisp-mode)))
     ("gnus"
      ((or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode))))
     ("programming"
      ((or
        (mode . emacs-lisp-mode)
        (mode . cperl-mode)
        (mode . c-mode)
        (mode . java-mode)
        (mode . idl-mode)
        (mode . lisp-mode)))))))
 '(jabber-activity-mode nil)
 '(org-agenda-files
   (quote
    ("~/projects/gitlab/configuration/nagios-files/organizer.org" "~/projects/puppet/organizer.org" "~/projects/gitlab/configuration/gathor/organizer.org" "~/projects/gitlab/development/csm/organizer.org" "~/projects/gitlab/configuration/morrell/organizer.org")))
 '(pallet-mode t)
 '(safe-local-variable-values
   (quote
    ((rspec-use-rake-when-possible)
     (rspec-use-bundler-when-possible)
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)
     (rspec-spec-command . "bin/spec")
     (rspec-spec-command . "./bin/rspec")
     (enh-ruby-program . "/Users/cthompson/.rbenv/shims/ruby")
     (rspec-use-bundler-when-possible . t)
     (feature-cucumber-command . "bin/cucumber FEATURE=\"{feature}\"")
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(clojure-test-success-face ((t (:foreground "green" :underline t :weight bold))) t)
;;  '(diredp-compressed-file-suffix ((t (:foreground "dark Blue"))) t)
;;  '(idle-highlight ((t (:inherit region :box (:line-width -1 :color "grey75" :style released-button)))))
;;  '(jabber-roster-user-online ((t (:foreground "Cyan" :slant normal :weight light))))
;;  '(magit-diff-add ((t (:foreground "chartreuse"))))
;;  '(magit-diff-del ((t (:foreground "red1"))))
;;  '(magit-diff-file-header ((t (:inherit diff-file-header :foreground "black"))))
;;  '(magit-diff-hunk-header ((t (:inherit diff-hunk-header :foreground "black"))))
;;  '(magit-item-highlight ((t nil)))
;;  '(window-numbering-face ((t (:background "grey" :foreground "black"))) t))
