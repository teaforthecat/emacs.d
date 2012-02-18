(defun spawn-shell (name cmds)
  "Invoke shell test"
  (interactive "MName of shell buffer to create: ")

  (if (get-buffer name)
      (progn 
        (setq ss-buffer (get-buffer name)))
    
    (progn (setq ss-buffer (get-buffer-create 
                     (generate-new-buffer-name name)))
           (shell ss-buffer)))

  (pop-to-buffer (get-buffer-create ss-buffer))
  (loop for cmd in cmds do         
        (process-send-string nil cmd )
        )
  (comint-send-input)
)

(spawn-shell "server" (list "virtenv;" 
                            "cd;"
                            "cd ~/walkerart;" 
                            "./manage.py runserver;"))


;; (spawn-shell "test" (list "virtenv;" 
;;                           "cd;"
;;                           "cd ~/walkerart;" 
;;                           "./manage.py test -x --test-settings;"))


