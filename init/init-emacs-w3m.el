(if (string-match "apple-darwin" system-configuration)
    (setq w3m-command "/usr/local/bin/w3m"))

;;(require 'w3m-search)

;;(require 'w3m-cookie) ;; helm, w3m-session requires this without declaring a dependency

(setq w3m-use-cookies t)

;;(add-to-list 'w3m-search-engine-alist
;;             '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))

 
