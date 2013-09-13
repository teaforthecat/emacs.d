
(defvar ftf-project-definers '("organizer.org" ;my addition
                               ".dir-locals.el"
                               ".emacs-project"))

(defun ftf-find-locals-directory ()
  "Returns the directory that contains either `.dir-locals.el' or
  `.emacs-project' or nil if no path components contain such a directory."
  (defun parent-dir (path)
    (file-name-directory (directory-file-name path)))

  ;; old inflexible:  
  ;; (defun dir-has-project-file (path)
  ;;   (or (file-exists-p (concat path "/.dir-locals.el"))
  ;;       (file-exists-p (concat path "/.emacs-project"))))

  ;; new flexible:
  (defun dir-has-project-file (path)
    (-any? 'file-exists-p (-map (lambda (d) 
                                  (concat path "/" d)) 
                                ftf-project-definers)))   

  (let ((path default-directory)
        (return-path nil))
    (while path
      (cond ((string-equal path "/")
             (setq return-path nil
                   path nil))
            ((dir-has-project-file path)
             (setq return-path path
                   path nil))
            (t (set 'path (parent-dir path)))))
    return-path))
