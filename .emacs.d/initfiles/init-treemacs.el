(use-package treemacs
  :ensure t
  :custom
  (treemacs-no-png-images t)
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t)
  (treemacs-project-follow-cleanup t)
  :delight)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(provide 'init-treemacs)
