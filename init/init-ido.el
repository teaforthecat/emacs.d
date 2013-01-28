(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-url-at-point t)
;;(setq ido-unc- stuff ) ; samba servers
(setq ido-use-virtual-buffers t) ;remember previously opened files
(ido-mode t)
(ido-everywhere t) ;ido.el both files and buffers
;; (add-hook 'ido-setup-hook 'ido-my-keys)
;; change keybindings here

(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion 
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (ido-completing-read "Project File: "
                         (tags-table-files)
                         nil t)))

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
