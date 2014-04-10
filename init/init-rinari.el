(add-to-list 'rinari-major-modes 'magit-mode-hook )
(setq rinari-rgrep-file-endings   "*.[^l]*")
;;need to remap eval-region to something
(define-key ruby-mode-map "\C-c\C-r" nil)

;; this is actually a rails thing
(setq rails-ui:show-mode-line nil)

(setq rinari-tags-file-name "TAGS")

(defun rinari-console (&optional edit-cmd-args)
  "Run a Rails console in a compilation buffer.
The buffer will support command history and links between errors
and source code.  Optional prefix argument EDIT-CMD-ARGS lets the
user edit the console command arguments."
  (interactive "P")
  (let* ((default-directory (rinari-root))
         (command (rinari--wrap-rails-command "console")))

    ;; Start console in correct environment.
    (when rinari-rails-env
      (setq command (concat command " " rinari-rails-env)))

    ;; For customization of the console command with prefix arg.
    (setq command (or edit-cmd-args
                      command))
    (with-current-buffer (run-ruby command "zeus console")
      (dolist (var '(inf-ruby-prompt-pattern inf-ruby-first-prompt-pattern))
        (set (make-local-variable var) rinari-inf-ruby-prompt-pattern))
      (rinari-launch))))

;;(setenv "DYLD_LIBRARY_PATH" (getenv "ORACLE_HOME"))
