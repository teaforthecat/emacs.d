;;-*- byte-compile-dynamic: t; -*-

;;http://stackoverflow.com/questions/435847/emacs-mode-to-edit-json/7934783#7934783
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))


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



;; http://stackoverflow.com/a/14539202/714357
(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
      (when mark-ring
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
        (when (null (mark t)) (ding))
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))

;; this causes invalid byte code
;; this goes with the above
;; http://stackoverflow.com/a/5117076/714357
(defmacro my-unpop-to-mark-advice ()
  "Enable reversing direction with un/pop-to-mark."
  `(defadvice ,(key-binding (kbd "C-SPC")) (around my-unpop-to-mark activate)
     "Unpop-to-mark with negative arg"
     (let* ((arg (ad-get-arg 0))
            (num (prefix-numeric-value arg)))
       (cond
        ;; Enabled repeated un-pops with C-SPC
        ((eq last-command 'unpop-to-mark-command)
         (if (and arg (> num 0) (<= num 4))
             ad-do-it ;; C-u C-SPC reverses back to normal direction
           ;; Otherwise continue to un-pop
           (setq this-command 'unpop-to-mark-command)
           (unpop-to-mark-command)))
        ;; Negative argument un-pops: C-- C-SPC
        ((< num 0)
         (setq this-command 'unpop-to-mark-command)
         (unpop-to-mark-command))
        (t
         ad-do-it)))))

(my-unpop-to-mark-advice)


;; http://ergoemacs.org/emacs/elisp_generate_uuid.html
;; by Christopher Wellons, 2011-11-18. Editted by Xah Lee.
;; Edited by Hideki Saito further to generate all valid variants for "N" in xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx format.
(defun insert-uuid-internal ()
  "Insert a UUID. This uses a simple hashing of variable data."
  (interactive)
  (let ((myStr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                (user-uid)
                (emacs-pid)
                (system-name)
                (user-full-name)
                (current-time)
                (emacs-uptime)
                (garbage-collect)
                (buffer-string)
                (random)
                (recent-keys)))))

    (insert (format "%s-%s-4%s-%s%s-%s"
                    (substring myStr 0 8)
                    (substring myStr 8 12)
                    (substring myStr 13 16)
            (format "%x" (+ 8 (random 4)))
                    (substring myStr 17 20)
                    (substring myStr 20 32)))))

;;http://stackoverflow.com/a/22609399/714357
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (set-window-dedicated-p (selected-window) sticky-buffer-mode))

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
;; does major modes - replaced by diminish
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))


;; http://stackoverflow.com/a/12101330
(defun find-file-at-point-with-line ()
  "if file has an attached line num goto that line, ie boom.rb:12"
  (interactive)
  (let ((line-num
         (save-excursion
           (search-forward-regexp "[^ ]:" (point-max) t)
           (if (looking-at "[0-9]+")
               (string-to-number (buffer-substring (match-beginning 0) (match-end 0))))))
        (file-path (ffap-guesser)))
    (other-window 1)
    (find-file file-path)
    ;; (ffap file-path) ;;for urls
    (if (not (equal line-num 0))
        (progn (goto-char (point-min))(forward-line (1- line-num))))))

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
    (forward-line 1)
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

;;http://www.emacswiki.org/emacs/RaymondZeitler
(defun shellfn ()
  "Invokes the shell using the current buffer file name as a parameter."
  (interactive)
  (shell (concat "echo " (buffer-file-name))))


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
