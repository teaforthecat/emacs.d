;;http://stackoverflow.com/questions/435847/emacs-mode-to-edit-json/7934783#7934783
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;;http://stackoverflow.com/questions/4551283/what-is-wrong-with-my-emacs-slime-setup-compile-and-load-eval-not-working
(defun contrib/slime-clojure ()
  (interactive)
  ;; (add-to-list 'load-path "~/hacking/lisp/elpa-slime")
  (require 'slime)
  (slime-setup '(slime-repl))
  (slime-connect "localhost" 4005))


;; unknown
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))


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

;;http://www.emacswiki.org/cgi-bin/wiki/TrampMode#Chris Allen
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))
(eval-after-load "tramp"
  '(progn
     (defvar sudo-tramp-prefix 
       "/sudo:" 
       (concat "Prefix to be used by sudo commands when building tramp path "))
     (defun sudo-file-name (filename)
       (set 'splitname (split-string filename ":"))
       (if (> (length splitname) 1)
         (progn (set 'final-split (cdr splitname))
                (set 'sudo-tramp-prefix "/sudo:")
                )
         (progn (set 'final-split splitname)
                (set 'sudo-tramp-prefix (concat sudo-tramp-prefix "root@localhost:")))
         )
       (set 'final-fn (concat sudo-tramp-prefix (mapconcat (lambda (e) e) final-split ":")))
       (message "splitname is %s" splitname)
       (message "sudo-tramp-prefix is %s" sudo-tramp-prefix)
       (message "final-split is %s" final-split)
       (message "final-fn is %s" final-fn)
       (message "%s" final-fn)
       )

     (defun sudo-find-file (filename &optional wildcards)
       "Calls find-file with filename with sudo-tramp-prefix prepended"
       (interactive "fFind file with sudo ")      
       (let ((sudo-name (sudo-file-name filename)))
         (apply 'find-file 
                (cons sudo-name (if (boundp 'wildcards) '(wildcards))))))

     (defun sudo-reopen-file ()
       "Reopen file as root by prefixing its name with sudo-tramp-prefix and by clearing buffer-read-only"
       (interactive)
       (let* 
           ((file-name (expand-file-name buffer-file-name))
            (sudo-name (sudo-file-name file-name)))
         (progn           
           (setq buffer-file-name sudo-name)
           (rename-buffer sudo-name)
           (setq buffer-read-only nil)
           (message (concat "File name set to " sudo-name)))))

     ;;(global-set-key (kbd "C-c o") 'sudo-find-file)
     (global-set-key (kbd "C-c s u ") 'sudo-reopen-file)))

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

;; from: http://curiousprogrammer.wordpress.com/2009/04/02/ibuffer/
(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))




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


;; from newartisans.com/2007/08/using-org-mode-as-a-day-planner.html
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(provide 'contrib-functions)
