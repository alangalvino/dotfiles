;;;; Evil configs

;; Packages
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t)
  (evil-set-undo-system 'undo-redo)

  ;; Repeat search with 'S' and 's'
  (define-key evil-normal-state-map "s" 'evil-search-next)
  (define-key evil-normal-state-map "S" 'evil-search-previous)

  ;; to the last non-blank character of a line with 'L' and 'N'
  (define-key evil-motion-state-map "L" 'evil-last-non-blank)
  (define-key evil-visual-state-map "L" 'evil-last-non-blank)
  (define-key evil-motion-state-map "N" 'evil-last-non-blank)
  (define-key evil-visual-state-map "N" 'evil-last-non-blank)

  ;; to the beginning of line with 'H'
  (define-key evil-motion-state-map "H" 'beginning-of-line-text)
  (define-key evil-visual-state-map "H" 'beginning-of-line-text)

  ;; remap change word to 'C' (capital 'c')
  (define-key evil-visual-state-map "c" 'evil-change)
  (define-key evil-normal-state-map "C" 'evil-change)

  ;; remap movement keys to htcn (dvorak)
  (define-key evil-normal-state-map "c" 'evil-previous-line)
  (define-key evil-visual-state-map "t" 'evil-next-line)
  (define-key evil-normal-state-map "t" 'evil-next-line)
  (define-key evil-visual-state-map "n" 'evil-forward-char)
  (define-key evil-normal-state-map "n" 'evil-forward-char)

  ;;  Ctrl + g as ESC
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Ctrl + y as yank
  (define-key evil-insert-state-map (kbd "C-y") 'yank)
  (define-key evil-motion-state-map (kbd "C-y") 'yank)
  (define-key evil-visual-state-map (kbd "C-y") 'yank)

  ;; Ctrl + h as delete backward char
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char)
  (define-key evil-motion-state-map (kbd "C-h") 'evil-delete-backward-char)
  (define-key evil-visual-state-map (kbd "C-h") 'evil-delete-backward-char)

  ;; Find function definition
  (define-key evil-insert-state-map (kbd "M-.") 'xref-find-definitions)
  (define-key evil-motion-state-map (kbd "M-.") 'xref-find-definitions)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
  (define-key evil-visual-state-map (kbd "M-.") 'xref-find-definitions)

  (define-key evil-visual-state-map "-" 'comment-or-uncomment-region))

(use-package evil-leader
  :ensure t
  :after evil
  :diminish
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ":"     'helm-M-x
    "<SPC>" 'helm-M-x
    ;; f for files
    "f"   'helm-find-file-or-projectile
    "n"   'helm-find-my-notes
    "w"   'helm-find-my-workspace
    ;; g for git
    "g"   'magit-status
    ;; search word
    "/"   'helm-occur
    ;; t for terminal
    "t"   'vterm-toggle
    ;; e for editing
    "e"   'darkroom-tentative-mode
    ;; d for dired
    "d"   'treemacs-display-current-project-exclusively
    ;; s for slime
    "s"   'slime
    ;; kill buffers
    "k"   'kill-other-buffers
    ;; kill server
    "q"   'server-shutdown
    ;; random
    "F"   'toggle-frame-fullscreen
    "|"   'split-window-horizontally
    "_"   'split-window-vertically))

(use-package evil-collection
  :after evil
  :delight
  :ensure t
  :config
  (evil-collection-init)
  (evil-collection-define-key 'normal 'slime-mode-map
    (kbd "M-.") 'slime-edit-definition)
  (evil-collection-define-key 'normal 'slime-repl-mode-map
    (kbd "C-r") 'helm-slime-repl-history
    (kbd "C-m") 'slime-repl-return)
  (evil-collection-define-key 'normal 'org-mode-map
    "RET"        '+org/dwim-at-point
    [return]     '+org/dwim-at-point
    "C-S-RET"    '+org/insert-item-above
    [C-S-return] '+org/insert-item-above
    "C-RET"      '+org/insert-item-below
    [C-return]   '+org/insert-item-below)
  (evil-collection-define-key 'insert 'org-mode-map
    "RET"         '+org/return
    [return]     '+org/return
    "S-RET"      '+org/shift-return
    [S-return]   '+org/shift-return
    "C-S-RET"    '+org/insert-item-above
    [C-S-return] '+org/insert-item-above
    "C-RET"      '+org/insert-item-below
    [C-return]   '+org-insert-item-below))

(provide 'init-evil)
