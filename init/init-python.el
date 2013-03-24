;; setup python mode
(setq auto-mode-alist ; trigger python mode automatically
      (cons '("\\.py$" . python-mode) auto-mode-alist))

(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t)

(setq hs-special-modes-alist
	  (cons (list 
             'python-mode "^\\s-*def\\>" nil "#" 
             (lambda (arg)
               (py-end-of-def-or-class)
               (skip-chars-backward " \t\n"))
             nil) hs-special-modes-alist))

(add-hook 'python-mode-hook
          (lambda ()
            
            'hs-minor-mode
            (set-variable 'py-indent-offset 4)
            (set-variable 'py-smart-indentation t)
            (set-variable 'indent-tabs-mode nil)
            (define-key py-mode-map (kbd "RET") 'newline-and-indent)
            (define-key py-mode-map [tab] 'yas/expand)))

;; Auto Syntax Error Hightlight
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)

