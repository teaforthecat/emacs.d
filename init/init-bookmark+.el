(require 'bookmark+-lit);;fancy


(setq bookmark-default-file "~/.emacs.d/private/bookmarks")

;; copied from contrib/quick-jump.el,
;; because I'm not sure about auto-acceptance yet
(defun bookmark-ido-quick-jump ()
  "Jump to selected bookmark, using auto-completion and auto-acceptance."
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump
   (ido-completing-read "Jump to bookmark: " 
                        (loop for b in bookmark-alist collect (car b)))))


