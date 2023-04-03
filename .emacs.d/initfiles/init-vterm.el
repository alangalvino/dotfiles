(use-package vterm
  :ensure t
  :custom
  (vterm-kill-buffer-on-exit t)
  (vterm-buffer-name-string "vterm")
  :hook
  ('vterm-mode . (lambda () (setq-local global-hl-line-mode (null global-hl-line-mode)))))

(use-package vterm-toggle
  :ensure t
  :custom
  (vterm-toggle-hide-method 'delete-window)
  (vterm-toggle-fullscreen-p nil))

(provide 'init-vterm)
