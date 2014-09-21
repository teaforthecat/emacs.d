(setq comint-input-ring-file-name "~/.emacs.d/tmp/comint-history")
;default (setq comint-history-isearch nil);;disruptive and has blank history
(setq comint-buffer-maximum-size 1000)
(setq comint-input-ignoredups t)
(setq comint-history-isearch 'dwim)

;; for pianobar: <esc>[2k
(defconst ansi-color-drop-regexp
  "\033\\[\\([ABCDsuK]\\|2J\\|2K\\|=[0-9]+[hI]\\|[0-9;]*[Hf]\\)"
  "Regexp that matches ANSI control sequences to silently drop.")

;; made for the zeus start command
(defun ansi-pre-command-truncate-buffer (&optional _string)
  "honor the ansi command to clear text"
  (if (or (string-match "\\[19A" _string)
          (string-match "\\[20A" _string)
          )
      (progn
        (delete-region (point-min) (point-max))
        (substring _string 5))
    _string))

;;1A and 1B are cursor movement commands 0G is clear tab;
;; http://ascii-table.com/ansi-escape-sequences-vt-100.php
;; TODO: slit up b and g into two steps
(defun ansi-pre-command-a-b-string (&optional _string)
  "for ruby pry"
  (car (last (s-split "\\[1B\\[0G" _string))))


(add-hook 'comint-preoutput-filter-functions 'ansi-pre-command-truncate-buffer)
(add-hook 'comint-preoutput-filter-functions 'ansi-pre-command-a-b-string)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(add-to-list 'completion-at-point-functions 'comint-dynamic-list-filename-completions)
(add-hook 'comint-mode 'ansi-color-for-comint-mode-on)




;; (make-comint "zeus" "/bin/bash -l -c 'zeus start'" )
;; (make-comint "zeus" (start-file-process "which" "zeus" "which"  "bash")  )
;; (compile "ls" t)
;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (unless (or (file-exists-p \"makefile\")
;;                         (file-exists-p \"Makefile\"))
;;               (set (make-local-variable 'compile-command)
;;                    (concat \"make -k \"
;;                            (file-name-sans-extension buffer-file-name))))))
;; (compilation-start "cd ~/ruby; ls")
;; (defun start-message ()
;;   (delete-region 1 compilation-filter-start))
;; (make-variable-buffer-local 'compilation-filter-hook)
;; (add-hook 'compilation-filter-hook 'start-message)
