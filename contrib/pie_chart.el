;; http://www.emacswiki.org/emacs/GooglePieChart
(defun pie-chart ()
  "Use Google's Chart API to make a simple pie chart.
Inspired by
http://ryepup.unwashedmeme.com/blog/2008/04/05/adw-charting-to-get-a-lot-prettier/
I made this proof of concept.  Maybe someone else will make
something generic and useful with it..."
  (interactive)
  (let ((fname "~/tmpchart.png")
        (content
         (save-excursion
           (set-buffer
            (url-retrieve-synchronously
             "http://chart.apis.google.com/chart?chtt=Coolness&cht=p3&chd=t:90,10&chs=250x100&chl=Emacs|Vi"))
           (search-forward "\n\n")
           (buffer-substring-no-properties (point) (point-max)))))
    (with-temp-file fname
      (insert content))
    (view-file-other-window fname)))
