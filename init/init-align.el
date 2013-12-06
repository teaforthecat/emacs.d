(require 'align)
(add-to-list 'align-rules-list
             '(ruby-arrow
               (regexp   . "\\(\\s-*\\)=>\\(\\s-*\\)")
               (group    . (1 2))
               (modes    . '(ruby-mode puppet-mode))))
