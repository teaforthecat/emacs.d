(fset 'django-tags-to-hamlpy
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\363%}\345\345\323{%\365\365-" 0 "%d")) arg)))
(global-set-key [24 11 49] 'django-tags-to-hamlpy)

(fset 'haml2hamlpy
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\363=>\345\345:\347\345'\362'" 0 "%d")) arg)))
(global-set-key [24 11 50] 'haml2hamlpy)


(fset 'rerun-last-manage
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217825 99 111 109 45 105 115 tab return 109 97 110 97 103 101 13 return] 0 "%d")) arg)))

(fset 'step-correct-regex
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\363^\"\350\\" 0 "%d")) arg)))

(fset 'comma-space
   "\363,\C-m ")

;; embed previous word in ruby string as this => "#{this}"
(fset 'embed-in-ruby-string
   [?\C-  ?\M-g ?\" ?\M-h ?\C-  ?\M-g ?\{ ?\M-h ?# ?\C-u ?\C-  ?\M-n])


(fset 'rexpects
   (lambda (&optional arg) "turn real method call into an expected one of the mocha kind" (interactive "p") (kmacro-exec-ring-item (quote ([101 120 112 101 99 116 115 32 58 134217832 134217832 67108896 134217811 32 134217811 32 13 40 21 67108896 134217838 134217845 134217787 46 114 101 116 117 110 115 32] 0 "%d")) arg)))


;; (fset 'start-server
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217825 115 104 101 tab return 118 105 114 116 101 110 118 return 99 100 return 99 100 32 119 tab 97 tab return 46 47 109 97 110 tab 117 110 backspace backspace 114 117 110 115 101 114 118 101 114 return] 0 "%d")) arg)))
;; (fset 'start-server
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217825 115 104 101 108 108 return 99 100 return 99 100 32 119 97 108 107 101 114 97 114 116 return 118 105 114 116 101 110 118 return 46 47 109 97 110 97 103 101 46 112 121 32 114 117 110 115 101 114 118 101 114 return] 0 "%d")) arg)))

(fset 'pprint-comma-structure
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217811 44 13 return] 0 "%d")) arg)))

(fset 'deactivate-node
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([67108896 134217806 134217825 114 101 109 return 112 111 backspace 114 111 100 45 112 117 112 112 101 116 49 46 101 112 46 103 100 105 return 115 117 100 111 32 45 105 32 112 117 112 112 101 116 32 110 111 100 101 32 100 101 97 99 116 105 118 97 116 101 32 134217835 134217837 134217837 134217834 134217847 134217847 134217831 134217831 134217831 134217831 134217831 134217835 134217833 return 134217837 134217837] 0 "%d")) arg)))



(provide 'my-macros)
