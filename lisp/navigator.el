(require 'bind-key)


(bind-key* "M-t" 'next-line)
(bind-key* "M-T" 'scroll-up)

(bind-key* "M-h" 'backward-char)
(bind-key* "M-C" 'scroll-down)
(bind-key* "C-d" 'duplicate-line-or-region)
(bind-key* "M-l" 'recenter-top-bottom)






(provide 'navigator)
