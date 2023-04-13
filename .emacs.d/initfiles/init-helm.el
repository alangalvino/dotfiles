;;;; Helm configs

(use-package helm
  :ensure t
  :delight
  :bind
  ("M-x" . 'helm-M-x)
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-o" . 'helm-occur)
  ("C-x C-b" . 'helm-buffers-list)
  (:map helm-command-map
        ("C-j" . 'helm-next-line)
        ("C-k" . 'helm-previous-line))
  :custom
  (helm-split-window-in-side-p t)
  (helm-recentf-fuzzy-match t)
  (helm-buffers-fuzzy-matching t)
  (helm-M-x-fuzzy-match t)
  (helm-semantic-fuzzy-match t)
  (helm-apropos-fuzzy-match t)
  (helm-lisp-fuzzy-completion t))

(defun helm-find-file-or-projectile ()
  "If on projectile tries to find file with projectile if not with helm"
  (interactive)
  (if (projectile-project-p)
      (call-interactively 'helm-projectile-find-file)
    (call-interactively 'helm-find-files)))

(defun helm-find-in-dir (dir)
  (let ((default-directory dir))
    (helm-find-files nil)))

(defun helm-find-my-notes ()
  (interactive)
  (helm-find-in-dir org-notes-home-dir))

(defun helm-find-my-workspace ()
  (interactive)
  (helm-find-in-dir user-workspace-dir))

(provide 'init-helm)
