(defun spawn-shell (name &optional cmds)
  "Invoke shell in buffer NAME with optional list of COMMANDS"
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

(spawn-shell "django" (list "virtenv;" 
                            "cd;"
                            "cd ~/walkerart;" 
                            "./manage.py runserver;"))


(spawn-shell "collections-server" (list "cd ~/ruby/collections;" 
                                 "bin/rails s;"))
(spawn-shell "local" (list "cd"))


