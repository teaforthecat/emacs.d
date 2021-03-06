(require 's)
(require 'dash)
(require 'request)
(require 'ack-and-a-half)

(defun my/ls-mode-numbers ()
  (interactive)
  ;;http://stackoverflow.com/a/1796009/714357
  (compile " ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
             *2^(8-i));if(k)printf(\"%0o \",k);print}'"))

(defun search-organizer (term)
  "search with mdfind for TERM in all files named organizer.org"
  (interactive "Ssearch: ")
  (compilation-start
   (format
    "mdfind -name organizer.org -0 | xargs -0  ack --nocolor --nogroup --column %s "
    (shell-quote-argument term))
   'ack-and-a-half-mode))

;;replace this[^;
;;]+ with \&;
;; to add missing semi-colons


;;(refresh-dsh-groups elgin-hosts)
(defun refresh-dsh-groups (host-url-template)
  "writes hosts to dsh group files by environment using host-url-template"
  (let* ((environments  '(poc qc int stg prod))
         (file-template "~/.dsh/group/%s"))
    (dolist (env environments)
      (let* ((response (request (format host-url-template env)
                            :parser 'json-read
                            :sync t))
             (data (request-response-data response))
             (file-path (format file-template env)))
        (message (format "writing to %s" file-path))
        (write-lines (-map '(lambda (s) (format "%s.tops.gdi" s)) ;s is the hostname
                           (-map 'car data))
                     file-path)))))

(defun grep-log-pe-httpd (seek-regex)
  " run grep on puppetmaster.access.log"
  (interactive "Sgrep for: ")
  (let* ((default-directory "/sudo:puppet.tops.gdi:/var/log/pe-httpd/")
        (log-file  "puppetmaster.access.log")
        (compilation-buffer-name-function (lambda (buffer) (format  "* %s in %s *" seek-regex log-file ))) )
    (compile (format "grep --color=always -n -H -e %s %s" seek-regex log-file) t)))

(defun my-locate (search)
  (interactive (list (read-string "regex: "  )))
  (let ((dir default-directory)
        (buf (get-buffer-create (format "*locate %s*" search))))
    (shell-command (format "locate -b %s --regex %s | xargs ls -al" dir search)
                   buf)
    (switch-to-buffer-other-window buf)))

(defun run-fetchmail (args)
  (interactive)
  (compile (concat "env LC_ALL=C fetchmail " args) ))

(defun run-fetchmail-verbose ()
  (interactive)
  (run-fetchmail "-v  --nodetach --nosyslog"))

(defun my-find-projects ()
  "go to projects/ with organizer.org files"
  (interactive)
  (let ((find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld")))
    (find-name-dired "~/projects" "organizer.org")))

(defvar ct/previous-project nil)

(defun my-ido-mdfind-project ()
  "open a dired buffer for a project that contains an organizer.org file and open shell as well!"
  (interactive)
  (let* ((project-dir "~/projects")
        (project-list (mdfind "organizer.org" (format "-onlyin %s" project-dir)))
        (chosen-project-name (ido-completing-read "project: " (-map 'car project-list)))
        (chosen-project-path (cdr (assoc chosen-project-name project-list)))
        (pre-project-marker (make-symbol (format "pre-%s" chosen-project-name)))
        (default-directory chosen-project-path))
    (window-configuration-to-register pre-project-marker)
    (setq ct/previous-project pre-project-marker)
    (dired default-directory)
    (delete-other-windows)
    (split-window-right)
    (other-window 1)
    (find-file "organizer.org")
    (other-window 1)
    (split-window-below)
    (other-window 1)
    (spawn-shell (format "*%s*" chosen-project-name))))

(defun goto-previous-project ()
  (interactive)
  (jump-to-register ct/previous-project))

(defun mdfind (file-name &optional opts)
  "return full paths of files matching name"
  (let ((mdopts nil))
    (with-temp-buffer
      (let ((default-directory "~")) ;;mdfind is global
        (shell-command (format "mdfind -name %s %s" file-name opts ) t))
      (let* ((paths (remove nil (split-string  (buffer-string) "\n")))
             (rm-full-path #'(lambda (s) (s-chop-prefix (expand-file-name "~/projects/") s)))
             (rm-project-marker-file #'(lambda (s) (s-chop-suffix "/organizer.org" s)))
             (names (-map rm-project-marker-file (-map rm-full-path paths))))
        (-zip names paths)))))

(defun dirname (path)
  "directory of path, must end in filename or /"
  (nth 1 (nreverse (split-string path "/" ))))

(defun where-am-i ()
  "copies present location into kill-ring and clipboard"
  (interactive)
  (kill-new (message (concat (minus-project-path buffer-file-name) ":" (int-to-string (line-number-at-pos))))))

(defun minus-project-path (path)
  (let (project-dir (expand-file-name "~/projects/"))
    (s-chop-prefix project-dir path)))

(defun visit-vagrant ()
  (interactive)
  "start a shell on a vagrant machine
   - must be in a vagrant project
   - must set IdentityFile in ssh config for Host: vagrant
   - to use sudo remove from default-directory and add it to ssh-config"
  (let* ((vm (ido-completing-read "vm: " (list-vagrant-vms) nil t ))
         (port (find-vagrant-port vm))
         (user "vagrant")
         (default-directory (concat "/ssh:" "vagrant#" port ":/vagrant")))
    (spawn-shell (format "*vagrant-%s*" vm))))

(defun list-vagrant-vms ()
  "parse names of vms from output of `vagrant status`"
  (call-vagrant
                (lambda ()
                  (let (vms (list))
                    (while (search-forward "running " nil t)
                      (beginning-of-line)
                      (add-to-list 'vms (thing-at-point 'word))
                      (kill-line))
                    vms))
                "status"))

(defun find-vagrant-port (&optional vm)
  "parse Port from output of `vagrant ssh-config`"
  (call-vagrant
              (lambda ()
                (unless (search-forward "Port" nil t)
                  (message "ERROR:%s" (buffer-string)))
                  (end-of-line)
                  (thing-at-point 'word))
              "ssh-config" vm ))

(defmacro call-vagrant (body &rest args)
  "pass args to the vagrant command and execute body within the context
   of the output from the vagrant command"
  `(with-temp-buffer
    (call-process  "vagrant" nil t nil ,@args)
    (goto-char (point-min))
      (,body)))

(defun goto-init-for ()
  "find the 'user init file' for a package managed el-get"
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
    (switch-to-buffer ss-buffer)
    (shell ss-buffer)
    (dolist (c cmds)
      (process-send-string nil c )
      (comint-send-input))))


(defun shell-clear ()
  "set max size to zero, then truncate buffer"
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
