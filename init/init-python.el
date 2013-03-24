
(if apple
    (setq flymake-python-pyflakes-executable "/usr/local/share/python/pyflakes"))

(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
