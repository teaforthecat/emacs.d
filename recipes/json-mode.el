(:name json-mode
       :type git
       :url "https://github.com/joshwnj/json-mode.git"
       :features json-mode
       :post-init (lambda () 
                    (add-to-list 'auto-mode-alist '("\\.json$" . json-mode)))
)
