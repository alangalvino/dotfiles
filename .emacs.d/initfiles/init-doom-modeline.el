(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-icon nil) 
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-battery nil)
  (doom-modeline-mode 1))

(provide 'init-doom-modeline)
