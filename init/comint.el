(make-comint "zeus" "/bin/bash -l -c 'zeus start'" )
(make-comint "zeus" (start-file-process "which" "zeus" "which"  "bash")  )



(compile "ls" t)

(add-hook 'c-mode-hook
          (lambda ()
            (unless (or (file-exists-p \"makefile\")
                        (file-exists-p \"Makefile\"))
              (set (make-local-variable 'compile-command)
                   (concat \"make -k \"
                           (file-name-sans-extension buffer-file-name))))))


(compilation-start "cd ~/ruby; ls")
