;;-*- byte-compile-dynamic: t; -*-

(require 's)
(require 'dash)
(require 'request)
;(require 'ack-and-a-half)
(require 'term)
(require 'json)
(require 'tramp)
(require 'animate)


(defun ct/blow-up-string (string vpos &optional hpos)
  "put string in buffer and then blow it up"
  (letf ((init-chars (lambda (str)
                      (animate-initialize str vpos
                                          (or hpos
                                              (max 0 (/ (- (window-width) (length string)) 2)))))))

    (let ((characters (funcall init-chars string))
          (show-trailing-whitespace nil)
          (indent-tabs-mode nil)
          (cursor-type nil)
          (starting-pause .05)
          (inc-pause      .005))

      ;; insert chars then remove, without disrupting user's undo list
      (let ((buffer-undo-list nil))
        (animate-step characters 1)
        (sit-for 1)
        (primitive-undo (length characters) buffer-undo-list))

      (setq characters (append characters (funcall init-chars "**##..")))

      (dotimes (i animate-n-steps)

        ;; Bind buffer-undo-list so it will be unchanged when we are done.
        ;; (We're going to undo all our changes anyway.)
        (let (buffer-undo-list
              list-to-undo)
          ;; use minus to count from 1.0 to zero
          (animate-step characters (/ (- animate-n-steps i) 1.0 animate-n-steps))
          ;; Make sure buffer is displayed starting at the beginning.
          (set-window-start nil 1)
          ;; Display it, and wait just a little while.
          (setq pause (+ starting-pause (* i inc-pause)))
          (sit-for pause)
          ;; Now undo the changes we made in the buffer.
          (setq list-to-undo buffer-undo-list)
          (while list-to-undo
            (let ((undo-in-progress t))
              (setq list-to-undo (primitive-undo 1 list-to-undo)))))))
  (undo-boundary)))


(defun ct/goodbye ()
  (interactive)
  (save-excursion
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (erase-buffer)
    (delete-other-windows)
    (let ((animate-n-steps 20))
      (ct/blow-up-string "goodbye" 30)))
  (save-buffers-kill-terminal 1))

;; [WIP]
;; (let ((service (prodigy-define-service
;;                  :name "* head *"
;;                  :cwd "~/.emacs.d/lisp"
;;                  :command "head"
;;                  :args '("my-functions.el")
;;                  ))
;;       )
;;   (prodigy-start-service service))

;; (defun ct/bookmark-shell-command ()
;;   (interactive)
;;   (let* ((bname (format "* %s *" (read-string "process buffer name: ")))
;;         (working-directory (read-string (format "working directory[%s]: " default-directory) nil nil default-directory))
;;         (full-command (s-split " " (read-string "command: ")))
;;         (command (car full-command))
;;         (args (cdr full-command)))
;;     (bmkp-make-function-bookmark bname `(lambda ()
;;                                           (prodigy-define-service
;;                                             :name ,bname
;;                                             :cwd ,working-directory
;;                                             :command ,command
;;                                             :args (quote ,args))
;;                                           ;; (add-to-list prodigy-services '(
;;                                           ;;                                   :name ,bname
;;                                           ;;                                   :cwd ,working-directory
;;                                           ;;                                   :command ,command
;;                                           ;;                                   :args (quote ,args)
;;                                           ;;                                   ))
;;                                           (prodigy-start-service ,bname)

                                          ;; ))))
(defun ct/bookmark-shell-command ()
  (interactive)
  (let ((bname (format "* %s *" (read-string "process buffer name: ")))
        (working-directory (read-string (format "working directory[%s]: " default-directory) nil nil default-directory))
        (command (read-string "command: ")))
    (bmkp-make-function-bookmark bname `(lambda ()
                                          (let ((default-directory ,working-directory))
                                            (async-shell-command ,command ,bname))))))

(defun buffer-switcher-shell ()
  (interactive)
  (ido-for-mode "Shell:" 'shell-mode))

(defun buffer-switcher-dired ()
  (interactive)
  (ido-for-mode "dired:" 'dired-mode))

(defun dired-ediff-marked-files ()
  "Run ediff on marked files."
  (interactive)
  (let ((marked-files (dired-get-marked-files)))
    (cond
     ((= (safe-length marked-files) 2)
      (ediff-files (nth 0 marked-files) (nth 1 marked-files)))
     ((= (safe-length marked-files)
         (ediff3 (nth 0 marked-files)
                 (nth 1 marked-files)
                 (nth 2 marked-files)))))))

(defun sudo-tramp-file-name (filename)
  (with-parsed-tramp-file-name filename nil
    (tramp-make-tramp-file-name "sudo" user host localname )))

(defun sudo-find-file (filename &optional wildcards)
  "Calls find-file with filename with sudo-tramp-prefix prepended"
  (interactive "FFind file with sudo ")
  (let ((sudo-name (sudo-tramp-file-name filename)))
    (message "sudo-name: %s" sudo-name)
    (apply 'find-file
           (cons sudo-name (if (boundp 'wildcards) '(wildcards))))))

(defun bookmark-ido-quick-jump ()
  "Jump to selected bookmark, using auto-completion and auto-acceptance."
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump
   (ido-completing-read "Jump to bookmark: "
                        (loop for b in bookmark-alist collect (car b)))))

;; gem install yaml json
(setq ruby-yaml-json-command "ruby -ryaml -rjson -e \"puts YAML.load(STDIN.read).to_json\"")

(defun ruby-yaml-json-parse (str)
  (with-temp-buffer
    (insert str)
    (shell-command-on-region (point-min) (point-max)
                             ruby-yaml-json-command
                             (current-buffer)
                             'replace)
    (goto-char (point-min))
    (json-read)))

(defun yaml-parse (&optional beg end)
  (let* ((str (buffer-substring-no-properties beg end))
         (json-data (ruby-yaml-json-parse str)))
    json-data))


(defun sql-creds-from-rails (connection-data connection-name)
  (let* ((connection-data (assoc connection-name connection-data))
         (adapter (assoc 'adapter connection-data)))
    adapter))

(setq rails-sql-product-map '((oracle_enhanced . oracle)
                              (mysql2          . mysql)))

(defun rails-translate-product (adapter)
  ;; TODO ms,postgres,sqlite...
  (cdr (assoc adapter rails-sql-product-map)))

(defun rails-db-at-point ()
  "parse the whole yaml file to allow injection, connect to db at point, prompt for tramp host (tunnel) if universal argument given"
  (interactive)
  (let* ((connection-name (symbol-at-point))
         (data (yaml-parse (point-min) (point-max)))
         (conn-creds (assoc connection-name data))
         (sql-product (rails-translate-product (intern (cdr (assoc 'adapter conn-creds)))))
         (sql-user (cdr (assoc 'username conn-creds)))
         ;;         (sql-password (or (assoc 'username conn-creds) (prompt)))
         (sql-server (cdr (assoc 'host conn-creds)))
         (sql-database (cdr (assoc 'database conn-creds)))
         (sql-port     (cdr (assoc 'port conn-creds))) ;; can be nil???
         (use-tramp current-prefix-arg))

    (let ((connection-action '((sql-product-interactive sql-product connection-name))))
      (if use-tramp
          (ct/cd-remote "ssh" "/etc" connection-action)
        (eval (car connection-action))))))

(defmacro lambdo (body)
  `'(lambda () (interactive) ,body))

;; TODO maybe collect all advice in one place
(defadvice dired-hide-subdir (around stay activate)
  "don't move the point"
  (let ((temp-mark (point)))
    ad-do-it
    (goto-char temp-mark)))

(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(defun ct/top ()
  (interactive)
  (let ((host (ct/completing-hosts)))
    (ansi-term "/bin/bash" "ansi-term")
    (term-line-mode)
    (insert "ssh ") (insert host)
    (term-send-input)
    (insert "htop")
    (term-send-input)
    (term-char-mode)))

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
    term)
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
        (ct/write-lines (-map '(lambda (s) (format "%s.tops.gdi" s)) ;s is the hostname
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


;; this was a nice function
;; (defun goto-init-for ()
;;   "find the 'user init file' for a package managed el-get"
;;   (interactive)
;;   (let* ((init-full-dir (expand-file-name el-get-user-package-directory))
;;          (init-dir (s-chop-prefix default-directory init-full-dir))
;;          (init-files (git-ls-full "~/.emacs.d" init-dir))
;;                ;; not sure why there is bad data in init-files here:
;;          (init-files (-filter '(lambda (f) (s-contains? (concat init-full-dir "/init-" ) f)) init-files))
;;          (package-names (-map '(lambda (f)
;;                                  (string-match "init-\\(.*\\).el" f)
;;                                  (match-string 1 f))
;;                               init-files))
;;          (tbl (-zip package-names init-files)))
;;          (find-file (cdr (assoc (ido-completing-read "init:" (-map 'car tbl)) tbl )))))


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

(defun ct/remote-host-name ()
  (if (tramp-tramp-file-p default-directory)
      (s-chop-suffix ".gdi" (tramp-file-name-real-host
                             (tramp-dissect-file-name default-directory)))
    nil))

(defun ct/shell-buffer-name ()
  (if (tramp-tramp-file-p default-directory)
      (concat (ct/remote-host-name) ":" (this-dir-name))
    (this-dir-name)))

(defun spawn-shell (name &optional cmds)
  "Invoke shell in buffer NAME with optional list of COMMANDS
   example (spawn-shell \"*.emacs.d*\" '(\"ls\" \"file init.el\"))"
  (interactive (list (read-string "Name: " (concat "*" (ct/shell-buffer-name) "*" ))))
  (let ((ss-buffer (or (get-buffer name)
                       (get-buffer-create (generate-new-buffer-name name)))))
    (switch-to-buffer ss-buffer)
    (shell ss-buffer)
    (dolist (c cmds)
      (process-send-string nil c )
      (comint-send-input))
    (ct/setup-shell-history)))

;;stores remote shell history locally
(defun ct/setup-shell-history ()
  (setq comint-input-ring-file-name
        (format "~/.bash_history.d/%s"
                (if (tramp-tramp-file-p default-directory)
                    tramp-current-host ;keeps value even when local ?
                  (s-chomp (shell-command-to-string "hostname")))))
  (comint-read-input-ring)) ;;maybe make this into a var

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


; Note: find group/ -size 0 -print0 | xargs -0 rm
; -print0 & -0 allow spaces in path names

(defun process-each-buffer (form)
  "In a dired buffer, perform an action on each marked file's buffer"
  (interactive
   (list (read-from-minibuffer "Eval on buffer(s): "
                                nil read-expression-map t
                                'read-expression-history)))
  (let ((file-list (dired-get-marked-files)))
    (save-excursion
      (mapc (lambda (f)
              (find-file f)
              (eval form))
            file-list))))




(provide 'my-functions)
