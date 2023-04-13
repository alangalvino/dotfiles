;;;; Org-mode configs

(with-eval-after-load "org"
  ;;; Org configs

  (setq org-notes-home-dir user-orgmode-dir)
  (setq org-startup-folded t)

  ;; Fix superscripts: https://necromuralist.github.io/posts/disabling-subscripting-in-org-mode/
  (setq org-use-sub-superscripts '{})

  ;; Org hooks
  (add-hook 'org-mode-hook (lambda ()
                             (company-mode -1)
                             (org-bullets-mode 1)
                             (org-toggle-pretty-entities)
                             (org-display-inline-images)
                             (org-indent-mode)
                             (auto-fill-mode)
                             (delight 'org-indent-mode nil t)))

;;; Org modules and packages

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((lisp . t)
     (shell . t)))
  
  (add-hook 'org-insert-heading-hook
            (lambda ()
              (save-excursion
                (org-back-to-heading)
                (org-set-property "CREATED_AT" (format-time-string "[%Y-%m-%d %T]")))))

  (require 'org-tempo))

(use-package org-bullets
  :ensure t
  :custom
  (org-hide-emphasis-markers t))

(use-package org-download
  :ensure t
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir (concat user-orgmode-dir "files/images"))
  (org-download-heading-lvl 0)
  (org-download-timestamp "org_%Y%m%d-%H%M%S_")
  (org-image-actual-width 900)
  (org-download-screenshot-method "xclip -selection clipboard -t image/png -o > '%s'")
  :bind
  ("C-M-y" . org-download-screenshot)
  :config
  (require 'org-download))

(provide 'init-org-mode)
