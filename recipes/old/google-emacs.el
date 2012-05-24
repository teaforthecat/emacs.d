(:name google-emacs
       :type http-tar
       :options ("xzf")
       :features google-calendar
       :load ("google-calendar.el" "bbdb-vcard-export.el" "google-contacts.el" )
       :url "http://emacs-google.googlecode.com/files/google-emacs-0.0.3.tgz")
