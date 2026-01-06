(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(dolist (p '(multiple-cursors markdown-mode forth-mode))
  (when (not (package-installed-p p))
    (package-install p)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq make-backup-files nil)

(ido-mode 1)

(load-file "~/.emacs.d/rebinder.el")

(require 'rebinder)

(define-key global-map (kbd "C-y") (rebinder-dynamic-binding "C-c"))
(define-key global-map (kbd "C-e") (rebinder-dynamic-binding "C-x"))

(rebinder-hook-to-mode 't 'after-change-major-mode-hook)

(define-key rebinder-mode-map (kbd "C-c") 'kill-ring-save)
(define-key rebinder-mode-map (kbd "C-x") 'kill-region)

(keymap-global-set "C-z" 'undo)
(keymap-global-set "C-s" 'save-buffer)
(keymap-global-set "C-v" 'yank)
(keymap-global-set "C-b" 'yank-pop)
(keymap-global-set "C-f" 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(keymap-global-set "C-a" 'mark-whole-buffer)
(keymap-global-set "C-o" 'ido-find-file)
(keymap-global-set "C-<tab>" 'ido-switch-buffer)
(keymap-global-set "C-w" 'ido-kill-buffer)
(keymap-global-set "C-," 'other-window)
(keymap-global-set "C-<home>" 'beginning-of-buffer)
(keymap-global-set "C-<end>" 'end-of-buffer)
(keymap-global-set "M-v" 'move-to-window-line-top-bottom)

(global-auto-revert-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(package-selected-packages '(forth-mode markdown-mode multiple-cursors)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight regular :height 110 :width normal)))))
