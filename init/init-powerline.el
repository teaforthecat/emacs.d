(setq powerline-color1 "gray30")
(setq powerline-color2 "gray45")
(setq powerline-arrow-shape 'curve);;or 'arrow
;(set-face-attribute 'mode-line nil :box nil)


;; (set-face-attribute 'mode-line nil
;;     :background "gray22"
;;     :foreground "F0DFAF" :box nil)

;; diff --git a/powerline.el b/powerline.el
;; index ab8aa26..16a6f7c 100644
;; --- a/powerline.el
;; +++ b/powerline.el
;; @@ -299,7 +299,7 @@ install the memoized function over the original function."
;;                                                          ((eq powerline-arrow-shape 'curve) 'half)
;;                                                          ((eq powerline-arrow-shape 'half)  'arrow)
;;                                                          (t                                 'arrow)))
;; -                                            (redraw-modeline))))
;; +                                            (force-mode-line-update))))
;;         ""))))
 
;;  (defun powerline-make-right
;; @@ -324,7 +324,7 @@ install the memoized function over the original function."
;;                                                        ((eq powerline-arrow-shape 'curve) 'half)
;;                                                        ((eq powerline-arrow-shape 'half)  'arrow)
;;                                                        (t                                 'arrow)))
;; -                                          (redraw-modeline))))
;; +                                          (force-mode-line-update))))
;;         "")
;;       (if arrow
;;           (propertize " " 'face plface)
;; @@ -406,7 +406,7 @@ install the memoized function over the original function."
;;                                          'mouse-1 (lambda () (interactive)
;;                                                     (setq powerline-buffer-size-suffix
;;                                                           (not powerline-buffer-size-suffix))
;; -                                                   (redraw-modeline)))))
;; +                                                   (force-mode-line-update)))))
;;  (defpowerline lcl         current-input-method-title)
;;  (defpowerline rmw         "%*")
;;  (defpowerline major-mode  (propertize (format-mode-line mode-name)
;; @@ -450,6 +450,8 @@ install the memoized function over the original function."
;;  (defpowerline status      "%s")
;;  (defpowerline emacsclient mode-line-client)
;;  (defpowerline vc vc-mode)
;; +(defpowerline jabber jabber-activity-mode-string)
;; +
 
;;  (defpowerline percent-xpm (propertize "  "
;;                                        'display
;; @@ -473,6 +475,7 @@ install the memoized function over the original function."
;;                               (powerline-minor-modes    'left        powerline-color1  )
;;                               (powerline-narrow         'left        powerline-color1  powerline-color2  )
;;                               (powerline-vc             'center                        powerline-color2  )
;; +                             (powerline-jabber         'left    nil                    powerline-color2  )
;;                               (powerline-make-fill                                     powerline-color2  )
;;                               (powerline-row            'right       powerline-color1  powerline-color2  )
;;                               (powerline-make-text      ":"          powerline-color1  )
