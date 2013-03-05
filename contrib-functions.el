;; http://stackoverflow.com/a/4717026/714357
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))


;;http://blog.jayfields.com/2012/11/elisp-duplicate-line.html
(defun duplicate-line ()
  (interactive)
  (let* ((cursor-column (current-column)))
    (move-beginning-of-line 1)
    (kill-line)
    (yank)
    (open-line 1)
    (next-line 1)
    (yank)
    (move-to-column cursor-column)))

;; http://stackoverflow.com/questions/5194294/how-to-remove-all-newlines-from-selected-region-in-emacs
(defun remove-newlines-in-region ()
  "Removes all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match " " nil t))))


;; http://www.emacswiki.org/emacs/AlignCommands
;; use with [[:space:]]+
(defun align-repeat (start end regexp)
  "Repeat alignment with respect to 
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end 
                (concat "\\(\\s-*\\)" regexp) 1 1 t))


;; http://www.emacswiki.org/emacs/HideShow
 (defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))

(defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))

;;http://www.emacswiki.org/emacs/RaymondZeitler
(defun shellfn ()
  "Invokes the shell using the current buffer file name as a parameter."
  (interactive)
  (shell (concat "echo " (buffer-file-name))))

;;http://stackoverflow.com/questions/1389835/how-to-run-django-shell-from-emacs
(defun django-server (&optional argprompt)
  (interactive "P")
  ;; Set the default shell if not already set
  (labels ((read-django-project-dir 
            (prompt dir)
            (let* ((dir (read-directory-name prompt dir))
                   (manage (expand-file-name (concat dir "manage.py"))))
              (if (file-exists-p manage)
                  (expand-file-name dir)
                (progn
                  (message "%s is not a Django project directory" manage)
                  (sleep-for .5)
                  (read-django-project-dir prompt dir))))))
    (let* ((dir (read-django-project-dir 
                 "project directory: " 
                 default-directory))
           (project-name (first 
                          (remove-if (lambda (s) (or (string= "src" s) (string= "" s))) 
                                     (reverse (split-string dir "/")))))
           (buffer-name (format "%s-server" project-name))
           (manage (concat dir "manage.py")))
      (cd dir)
      (if (not (equal (buffer-name) buffer-name))
          (switch-to-buffer-other-window
           (apply 'make-comint buffer-name manage nil '("runserver")))
        (apply 'make-comint buffer-name manage nil '("runserver")))
      (make-local-variable 'comint-prompt-regexp)
      (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
                                         py-shell-input-prompt-2-regexp "\\|"
                                         "^([Pp]db) "))
      (add-hook 'comint-output-filter-functions
                'py-comint-output-filter-function))))
  ;; pdbtrack
(defun django-testserver (&optional argprompt)
  (interactive "P")
  ;; Set the default shell if not already set
  (labels ((read-django-project-dir 
            (prompt dir)
            (let* ((dir (read-directory-name prompt dir))
                   (manage (expand-file-name (concat dir "manage.py"))))
              (if (file-exists-p manage)
                  (expand-file-name dir)
                (progn
                  (message "%s is not a Django project directory" manage)
                  (sleep-for .5)
                  (read-django-project-dir prompt dir))))))
    (let* ((dir (read-django-project-dir 
                 "project directory: " 
                 default-directory))
           (project-name (first 
                          (remove-if (lambda (s) (or (string= "src" s) (string= "" s))) 
                                     (reverse (split-string dir "/")))))
           (buffer-name (format "%s-testserver" project-name))
           (manage (concat dir "manage.py")))
      (cd dir)
      (if (not (equal (buffer-name) buffer-name))
          (switch-to-buffer-other-window
           (apply 'make-comint buffer-name manage nil '("testserver" "--addrport=localhost:7000")))
        (apply 'make-comint buffer-name manage nil '("testserver")))
      (make-local-variable 'comint-prompt-regexp)
      (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
                                         py-shell-input-prompt-2-regexp "\\|"
                                         "^([Pp]db) "))
      (add-hook 'comint-output-filter-functions
                'py-comint-output-filter-function))))

;;http://stackoverflow.com/questions/1389835/how-to-run-django-shell-from-emacs
(defun django-shell (&optional argprompt)
  (interactive "P")
  ;; Set the default shell if not already set
  (labels ((read-django-project-dir 
            (prompt dir)
            (let* ((dir (read-directory-name prompt dir))
                   (manage (expand-file-name (concat dir "manage.py"))))
              (if (file-exists-p manage)
                  (expand-file-name dir)
                (progn
                  (message "%s is not a Django project directory" manage)
                  (sleep-for .5)
                  (read-django-project-dir prompt dir))))))
    (let* ((dir (read-django-project-dir 
                 "project directory: " 
                 default-directory))
           (project-name (first 
                          (remove-if (lambda (s) (or (string= "src" s) (string= "" s))) 
                                     (reverse (split-string dir "/")))))
           (buffer-name (format "%s-shell" project-name))
           (manage (concat dir "manage.py")))
      (cd dir)
      (if (not (equal (buffer-name) buffer-name))
          (switch-to-buffer-other-window
           (apply 'make-comint buffer-name manage nil '("shell_plus")))
        (apply 'make-comint buffer-name manage nil '("shell_plus")))
      (make-local-variable 'comint-prompt-regexp)
      (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
                                         py-shell-input-prompt-2-regexp "\\|"
                                         "^([Pp]db) "))
      (add-hook 'comint-output-filter-functions
                'py-comint-output-filter-function))))
  ;; pdbtrack


;;trey jackson
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification 
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

;; programothesis
(defmacro cmd (name &rest body)
  "declare an interactive command without all the boilerplate"
  `(defun ,name ()
     ,(if (stringp (car body)) (car body))
     (interactive)
     ,@(if (stringp (car body)) (cdr `,body) body)))

(cmd isearch-other-window
     (save-selected-window
       (other-window 1)
       (isearch-forward)))





;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))


(provide 'contrib-functions)
