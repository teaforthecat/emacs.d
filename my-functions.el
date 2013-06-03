(defun query-camel-to-dash ()
  (interactive)
  ;; sidenote
  ;; "\\,(func whatever)" only works in interactive mode of q-r-r
  (query-replace-regexp "\\([a-z]\\)\\([A-Z]\\)" 
                        '(replace-eval-replacement 
                          concat "\\1-" (replace-quote (downcase (match-string 2))))
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
         (toggle-read-only -1)
         (end-of-buffer)
         (unwind-protect
             (rename-buffer ,name)
           (rename-uniquely))))


(defun spawn-shell (name &optional cmds)
  "Invoke shell in buffer NAME with optional list of COMMANDS"
  (interactive "MName of shell buffer to create: ")

  (if (get-buffer name)
      (progn
        (setq ss-buffer (get-buffer name)))
    (progn
      (setq ss-buffer (get-buffer-create
                       (generate-new-buffer-name name)))
      (shell ss-buffer)))

  (pop-to-buffer (get-buffer-create ss-buffer))
  (if cmds
      (progn
        (loop for cmd in cmds do
              (process-send-string nil cmd )
              (comint-send-input)))))

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
  (setq buffer-name "selenium-webdriver")
  (switch-to-buffer-other-window
   (apply 'make-comint buffer-name "/usr/bin/java" nil '( "-jar" "/home/cthompson/src/selenium-2.1.0/selenium-server-standalone-2.1.0.jar"))))






(provide 'my-functions)
