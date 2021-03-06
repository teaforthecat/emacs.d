;; https://gist.github.com/sabof/7363048
(defun es-make-minibuffer-frame ()
  (interactive)
  (let* (( last-recursion-depth )
         ( frame (make-frame '((width . 60)
                               (height . 4)
                               (minibuffer . only)
                               (title . "Emacs-Minibuffer"))))
         ( enable-recursive-minibuffers t)
         ;; Runs when going down a level, or when entering a prompt. Not ideal
         ( minibuffer-exit-hook (list (lambda ()
                                        (cond ( (or (= (recursion-depth) 1)
                                                    (and last-recursion-depth
                                                         (= (recursion-depth)
                                                            last-recursion-depth)))
                                                (run-with-timer 2 nil 'top-level))
                                              ( t (setq last-recursion-depth
                                                        (recursion-depth))))
                                        ))))
    (unwind-protect
         (with-selected-frame frame
           (call-interactively 'eval-expression)
           (sit-for 1))
      (delete-frame frame))))

;; scale all buffers
(defadvice text-scale-increase (around all-buffers (arg) activate)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      ad-do-it)))


;; http://stackoverflow.com/a/9761896/714357
(defmacro dribble-append-on-exit (current persistent)
  "Concatenate the dribble-file for this session to the persistent lossage log."
  (let ((command (format "cat %s >>%s && rm %s"
                         (shell-quote-argument (eval current))
                         (shell-quote-argument (eval persistent))
                         (shell-quote-argument (eval current)))))
    `(add-hook 'kill-emacs-hook
               (lambda () (shell-command ,command)))))

;; http://stackoverflow.com/a/13473856/714357
(defun joindirs (root &rest dirs)
  "Joins a series of directories together, like Python's os.path.join,
  (dotemacs-joindirs \"/tmp\" \"a\" \"b\" \"c\") => /tmp/a/b/c"

  (if (not dirs)
      root
    (apply 'joindirs
           (expand-file-name (car dirs) root)
           (cdr dirs))))


;; http://www.emacswiki.org/emacs/AddNumbers
;; (with some adjustments)
(defun calculator-sum-column (start end)
  "Adds numbers in rectangle."
  (interactive "r")
  (save-excursion
    (copy-rectangle-as-kill start end)
    (with-temp-buffer
      (progn
        (yank-rectangle)
        (message (buffer-string))
        (let ((sum 0))
          (goto-char (point-min))
          (while (re-search-forward "[0-9]*\\.?[0-9]+" nil t)
            (setq sum (+ sum (string-to-number (match-string 0)))))
          (message "Sum: %f" sum))))))

;; http://whattheemacsd.com/appearance.el-01.html
;; does major modes
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))


;; http://stackoverflow.com/a/12101330
(defun find-file-at-point-with-line ()
  "if file has an attached line num goto that line, ie boom.rb:12"
  (interactive)
  (let ((line-num 0))
    (save-excursion
      (search-forward-regexp "[^ ]:" (point-max) t)
      (if (looking-at "[0-9]+")
          (setq line-num (string-to-number (buffer-substring (match-beginning 0) (match-end 0))))))
    (find-file-other-window (ffap-guesser))
    (if (not (equal line-num 0))
        (goto-line line-num))))

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

(defvar hs-minor-mode)
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
  (cl-labels ((read-django-project-dir
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
  (cl-labels ((read-django-project-dir
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
  (cl-labels ((read-django-project-dir
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
