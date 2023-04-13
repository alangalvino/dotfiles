;;;; Common Lisp specific configs as Quicklisp and Slime

;; (require 'slime)

;; Load Slime helpers
(if (file-exists-p "~/.roswell/helper.el")
    (progn
      (load (expand-file-name "~/.roswell/helper.el"))
      (setq inferior-lisp-program "/usr/bin/ros -L sbcl -Q -l ~/.sbclrc run")))

(use-package helm-slime
  :ensure t)

(use-package slime-company
  :ensure t)

(provide 'init-slime)
