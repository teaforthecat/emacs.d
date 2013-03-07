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

(defmacro interact-with (name compilation)
  `(list ,compilation
         (switch-to-buffer-other-window "*compilation*")
         (shell-mode)
         (toggle-read-only -1)
         (end-of-buffer)
         (unwind-protect
             (rename-buffer ,name)
           (rename-uniquely))))

(defun zeus-console ()
  (interactive)
  (interact-with "console"
   (compile "./bin/zeus c")))

(defun lookup-word-def() 
  (interactive)
  (let (myword myurl) 
    (setq myword (if (and transient-mark-mode mark-active) 
                     (buffer-substring-no-properties (region-beginning)(region-end))
                   (thing-at-point 'symbol)))
    
    (let ((dict-buffer (get-buffer-create "*Dictionary buffer*")))
      (save-excursion 
        (buffer-disable-undo (set-buffer dict-buffer))
        (setq buffer-read-only nil)
        (setq disable-point-adjustment t)
        (erase-buffer)
        (display-buffer dict-buffer)
        
        (dictionary-new-search (cons myword "wn"))      
        (setq buffer-read-only t)
        (goto-char (point-min))
        ))))

;; pdbtrack
(defun run-selenium () 
  (interactive)
  (setq buffer-name "selenium-webdriver")
  (switch-to-buffer-other-window 
   (apply 'make-comint buffer-name "/usr/bin/java" nil '( "-jar" "/home/cthompson/src/selenium-2.1.0/selenium-server-standalone-2.1.0.jar"))))






;; (defun django-runfeature (feature-buffer)
;;   (interactive "b")
;;   (let 
;;       ;;problem with let
;;       (new-buffer-name (concat (buffer-name feature-buffer) "-run")
;;       project-dir "/home/cthompson/wactemp/"
;;       manage (concat project-dir  "manage.py")))
;;   (message new-buffer-name)
;;   (cd project-dir)
;;   (if (not (equal (buffer-name) new-buffer-name))
;;       (switch-to-buffer-other-window
;;        (apply 'make-comint new-buffer-name manage nil '("harvest" feature "--settings=test_settings")))
;;     (progn 
;;       (comint-quit-subjob)
;;       (apply 'make-comint buffer-name manage nil '("harvest" feature "--settings=test_settings")))))


  ;; (make-local-variable 'comint-prompt-regexp)

  ;; (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
  ;;                                    py-shell-input-prompt-2-regexp "\\|"
  ;;                                    "^([Pp]db) "))
  ;; (add-hook 'comint-output-filter-functions
  ;;           'py-comint-output-filter-function))))



(provide 'my-functions)
