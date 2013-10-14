
(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Your Name\n"
  \n "(:nicknames" ("Nickname: " " #:" str) & ")" | '(kill-whole-line -1)
  \n "#+email: your-email@server.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
)

(define-skeleton puppet-role
  "empty puppet role class"
  nil
  "class role::" (file-name-sans-extension (file-name-nondirectory buffer-file-name)) " {}"
)
