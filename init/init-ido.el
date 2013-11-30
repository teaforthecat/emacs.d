(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-url-at-point t)
;;(setq ido-unc- stuff ) ; samba servers
(setq ido-use-virtual-buffers t) ;remember previously opened files
(setq ido-max-window-height 20)
(setq ido-max-prospects 18)

(ido-mode t)
(ido-everywhere t) ;ido.el both files and buffers

;; vertical ido
(setq ido-decorations (quote ("\n=> " " " "\n   " "\n   ..."
                              "[" "]" " [No match]" " [Matched]"
                              " [Not readable]" " [Too big]" " [Confirm]")))


;; change keybindings here
(defun ido-my-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map " " 'ido-next-match)
  )
(add-hook 'ido-setup-hook 'ido-my-keys)


;; http://emacswiki.org/emacs/InteractivelyDoThings
;; this function is more helpfull than the one below
(defun ido-for-mode(prompt the-mode)
  (switch-to-buffer
   (ido-completing-read prompt
                        (save-excursion
                          (delq
                           nil
                           (mapcar (lambda (buf)
                                     (when (buffer-live-p buf)
                                       (with-current-buffer buf
                                         (and (eq major-mode the-mode)
                                              (buffer-name buf)))))
                                   (buffer-list)))))))

;; http://emacswiki.org/emacs/InteractivelyDoThings
(defun ido-shell-buffer()
  (interactive)
  (ido-for-mode "Shell:" 'shell-mode))

(defun ido-ruby-buffer()
  (interactive)
  (ido-for-mode "Ruby file:" 'ruby-mode))


;; http://emacswiki.org/emacs/InteractivelyDoThings
(defun rgr/ido-erc-buffer()
  "nice example of programattically using ido"
  (interactive)
  (switch-to-buffer
   (ido-completing-read "Channel:" 
                        (save-excursion
                          (delq
                           nil
                           (mapcar (lambda (buf)
                                     (when (buffer-live-p buf)
                                       (with-current-buffer buf
                                         (and (eq major-mode 'erc-mode)
                                              (buffer-name buf)))))
                                   (buffer-list)))))))

(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(defun my-ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))



;; http://whattheemacsd.com/setup-ido.el-02.html
(add-hook 'ido-setup-hook
 (lambda ()
   ;; Go straight home
   (define-key ido-file-completion-map
     (kbd "~")
     (lambda ()
       (interactive)
       (if (looking-back "/")
           (insert "~/")
         (call-interactively 'self-insert-command))))))
