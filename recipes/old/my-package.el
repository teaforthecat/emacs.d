(:name package
       :type http
       :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el"
       :features package
       :post-init (lambda ()
		    (setq package-user-dir 
			  (expand-file-name 
			   (convert-standard-filename 
			    (concat (file-name-as-directory 
				     (el-get-package-directory "package")) 
				    "elpa")))
			  package-directory-list 
			  (list (file-name-as-directory package-user-dir) 
				"/usr/share/emacs/site-lisp/elpa/"))
		    (make-directory package-user-dir t)
             (add-to-list 'package-archives
                         '("marmalade" . "http://marmalade-repo.org/packages/"))
		    (package-initialize)))
