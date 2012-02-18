(:name feature-mode
       :type git
       :url "https://github.com/teaforthecat/cucumber.el.git"
       :post-init (lambda () 
                    (add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode)))
)
