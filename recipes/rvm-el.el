(:name rvm-el
       :url "https://github.com/senny/rvm.el.git"
       :type git
       :post-init (lambda () 
                    (rvm-use-default)
                    )

)
