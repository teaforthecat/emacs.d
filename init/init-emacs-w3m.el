(setq w3m-use-cookies t)
(if (string-match "apple-darwin" system-configuration)
    (setq w3m-command "/usr/local/bin/w3m"))
