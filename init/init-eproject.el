;; (require 'eproject-ruby)
;; (require 'eproject-ruby-on-rails)


(setq eproject-completing-read-function 'eproject--ido-completing-read)


(define-project-type emacs.d (generic)
  (look-for "init.el")
  :irrelevant-files ("el-get/.*" "tmp"))

(define-project-type clojure (generic)
  (look-for "project.clj")
  :irrelevant-files ("logs/.*" "target/*"))

(define-project-type ruby-on-rails (generic)
  (and (look-for "Gemfile") (look-for "config/application.rb"))

  :irrelevant-files ("app/assets/images/.*"   "tmp/.*"   "log/.*"   "public/.*" 
                     "vendor/.*"   ".*\\.sqlite?"    "Gemfile.lock")
  :tasks (("server" :shell (if (file-exists-p ".zeus.sock") 
                               "zeus s" 
                             "rails s") )
          ("console" :shell (if (file-exists-p ".zeus.sock") 
                               "zeus c" 
                             "rails c") ))
  :main-file "Gemfile")






