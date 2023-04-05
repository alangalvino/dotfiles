;;;; Emacs GUI look & feel adjustments

;; Highlights chars in lines over whitespace-line-column siz
(setq whitespace-style '(face lines-tail))

;; Disable startup message
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Used by xdotool to bring emacs to foreground 
(setq frame-title-format "one-emacs")

;; Remove load average from display-time
(setq display-time-default-load-average nil)

;; Remove model line buffer percentage
(setq mode-line-percent-position nil)

;; Display the current time
(display-time-mode 1)

;; Smooth scrolling
;; (pixel-scroll-precision-mode t)

;; Do not display toolbar 
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)
(global-hl-line-mode t)
(blink-cursor-mode 0)

(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 200
                    :weight 'normal)

(provide 'init-gui)
