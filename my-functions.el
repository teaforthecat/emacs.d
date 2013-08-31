(require 's)
(require 'dash)

;;TODO tail-apache-logs select host, compile "tail -f /etc/httpd/logs/*"

(defun run-fetchmail (args)
  (interactive)
  (compile (concat "env LC_ALL=C fetchmail " args) ))

(defun run-fetchmail-verbose ()
  (interactive)
  (run-fetchmail "-v  --nodetach --nosyslog"))

(defun projects ()
  "go to projects/ with organizer.org files"
  (interactive)
    (find-name-dired "~/projects" "organizer.org"))

;; @wip
;; (with-temp-buffer
;;   (shell-command "find ~/projects \\( -name organizer.org \\)" (current-buffer))
;;   (-map 'dirname (split-string  (buffer-string) "\n")))

(defun dirname (path)
  "directory of path, must end in filename or /"
  (nth 1 (nreverse (split-string path "/" ))))

(dirname "this/that/")

(defun where-am-i ()
  "copies present location into kill-ring and clipboard"
  (interactive)
  (kill-new (message (concat buffer-file-name ":" (int-to-string (line-number-at-pos))))))

(defun visit-vagrant ()
  (interactive)
  "start a shell on a vagrant machine
   - must be in a vagrant project
   - must have only one machine
   - must set IdentityFile in ssh config for Host: vagrant"
  (let* ((port (find-vagrant-port))
         (user "vagrant")
         (default-directory (concat "/ssh:" user "@vagrant#" port ":/vagrant")))
    (spawn-shell "*vagrant*")))

(defun find-vagrant-port ()
  (with-temp-buffer
    (call-process  "vagrant" nil t nil "ssh-config")
    (goto-char (point-min))
    (unless (search-forward "Port")
      (message "ERROR:%s" (buffer-string)))
    (end-of-line)
    (thing-at-point 'word)))

(defun goto-init-for ()
  "find the 'user init file' for a package managed my el-get"
  (interactive)
  (let* ((init-full-dir (expand-file-name el-get-user-package-directory))
         (init-dir (s-chop-prefix default-directory init-full-dir))
         (init-files (git-ls-full "~/.emacs.d" init-dir))
               ;; not sure why there is bad data in init-files here:
         (init-files (-filter '(lambda (f) (s-contains? (concat init-full-dir "/init-" ) f)) init-files))
         (package-names (-map '(lambda (f)
                                 (string-match "init-\\(.*\\).el" f)
                                 (match-string 1 f))
                              init-files))
         (tbl (-zip package-names init-files)))
         (find-file (cdr (assoc (ido-completing-read "init:" (-map 'car tbl)) tbl )))))


(defun git-ls-full (path subpath)
  (with-temp-buffer ;; get the full file paths
    (cd (expand-file-name path))
    (shell-command (format "git ls-files %s" subpath) t)
    (-map 'expand-file-name (split-string (buffer-string) "\n"))))

(defun query-camel-to-dash ()
  (interactive)
  ;; tT -> t-t
  ;; sidenote
  ;; "\\,(func whatever)" only works in interactive mode of q-r-r
  (query-replace-regexp "\\([a-z]\\)\\([A-Z]\\)"
                        '(replace-eval-replacement
                          concat "\\1-" (replace-quote (downcase (match-string 2))))
                        nil
                        (if (and transient-mark-mode mark-active) (region-beginning))
                        (if (and transient-mark-mode mark-active) (region-end))))

(defun query-fix-hash-rockets ()
  (interactive)
  ;; t=>t -> t => t
  ;; needs Non-space regex matcher instead of letters
  ;; also maybe check for more than one space.
  (query-replace-regexp "\\([a-z]\\)=>\\([a-z]\\)"
                        '(replace-eval-replacement
                          concat (match-string 1) " => " (match-string 2))
                        nil
                        (if (and transient-mark-mode mark-active) (region-beginning))
                        (if (and transient-mark-mode mark-active) (region-end))))


(setq find-for-el-etags
      "find .  \(  -path ./el-get \) -prune -o -name \"*.el\"  -print | etags -" )

(setq find-for-rails-etags
      "ctags -e -a --Ruby-kinds=-fFcm -o TAGS -R .")

(defun set-tab-width-two ()
  (interactive)
  (set (make-local-variable 'tab-width) 2))

(defmacro interact-with (name compilation)
  `(list ,compilation
         (switch-to-buffer-other-window "*compilation*")
         (shell-mode)
         (read-only-mode -1)
         (goto-char (point-max))
         (unwind-protect
             (rename-buffer ,name)
           (rename-uniquely))))

(defun this-dir-name ()
  (car (last (delete "" (split-string default-directory "/")))))


(defun spawn-shell (name &optional cmds)
  "Invoke shell in buffer NAME with optional list of COMMANDS
   example (spawn-shell \"*.emacs.d*\" '(\"ls\" \"file init.el\"))"
  (interactive (list (read-string "Name: " (concat "*" (this-dir-name) "*" ))))  
  (let ((ss-buffer (or (get-buffer name)
                       (get-buffer-create (generate-new-buffer-name name)))))
    (pop-to-buffer ss-buffer)
    (shell ss-buffer)
    (dolist (c cmds)
      (process-send-string nil c )
      (comint-send-input))))


(defun shell-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun touch-app ()
  (interactive)
  (compile "touch config/application.rb"))

(defun production-jobs-count ()
  (interactive)
  (compile "ssh deployer@citra cd collections \\&\\& rake jobs:count"))

(defun production-jobs-tail ()
  (interactive)
  (compile "ssh deployer@citra tail -f collections/log/delayed_job.log"))

(defun production-console ()
  (interactive)
  (interact-with "*PRODUCTION CONSOLE*"
                 (compile "ssh deployer@citra cd collections \\&\\& ./bin/rails c")))

(defun zeus-console ()
  (interactive)
  (interact-with "*console*"
                 (compile "./bin/zeus c")))


;; pdbtrack
(defun run-selenium ()
  (interactive)
  (let ((buf-name "selenium-webdriver"))
    (switch-to-buffer-other-window
     (apply 'make-comint buf-name "/usr/bin/java" nil '( "-jar" "/home/cthompson/src/selenium-2.1.0/selenium-server-standalone-2.1.0.jar")))))





(provide 'my-functions)
