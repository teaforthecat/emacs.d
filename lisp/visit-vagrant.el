(require 'my-functions) ; for spawn-shell

;; Host vagrant
;;   IdentityFile /Users/cthompson/.vagrant.d/insecure_private_key
;;   Hostname localhost
;;   User vagrant
;;   StrictHostKeyChecking no
;;   UserKnownHostsFile /dev/null
(defun visit-vagrant ()
  (interactive)
  "start a shell on a vagrant machine
   - must be in a vagrant project
   - must set IdentityFile in ssh config for Host: vagrant
   - to use sudo remove from default-directory and add it to ssh-config"
  (let* ((vm (ido-completing-read "vm: " (list-vagrant-vms) nil nil ))
         (port (find-vagrant-port vm))
         (user "vagrant")
         (default-directory (concat "/ssh:" "vagrant#" port ":/vagrant")))
    (spawn-shell (format "~ VAGRANT-%s ~" vm))))


(defun list-vagrant-vms ()
  "parse names of vms from output of `vagrant status`"
  (call-vagrant
                (lambda ()
   (let (vms (list))
     (while (search-forward "running " nil t)
       (beginning-of-line)
       (add-to-list 'vms (thing-at-point 'symbol))
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

(provide 'visit-vagrant)
