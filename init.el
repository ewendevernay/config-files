(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(dolist (p '(multiple-cursors zenburn-theme visible-mark))
  (when (not (package-installed-p p))
    (package-install p)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)
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
(define-key isearch-mode-map "\C-v" 'isearch-yank-kill)
(keymap-global-set "C-a" 'mark-whole-buffer)
(keymap-global-set "C-o" 'ido-find-file)
(keymap-global-set "M-o" 'ido-dired)
(keymap-global-set "C-<tab>" 'ido-switch-buffer)
(keymap-global-set "C-w" 'ido-kill-buffer)
(keymap-global-set "C-," 'other-window)
(keymap-global-set "C-<home>" 'beginning-of-buffer)
(keymap-global-set "C-<end>" 'end-of-buffer)
(keymap-global-set "M-v" 'move-to-window-line-top-bottom)
(keymap-global-set "<backtab>" 'indent-region)
(keymap-global-set "<f5>" 'compile)

(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(keymap-global-set "M-<up>" 'move-text-up)
(keymap-global-set "M-<down>" 'move-text-down)

(require 'dired)
(define-key dired-mode-map "\C-o" 'ido-find-file)

(global-auto-revert-mode 1)

(setq transient-mark-mode nil)

(setq visible-mark-max 1)
(global-visible-mark-mode 1)

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "k&r")
            (setq indent-tabs-mode t)
	    (setq tab-width 2)
            (setq c-basic-offset tab-width)))

(require 'multiple-cursors)
(keymap-global-set "M-S-<down>" 'mc/mark-next-like-this)
(keymap-global-set "M-S-<up>" 'mc/mark-previous-like-this)
(keymap-global-set "C-d" 'mc/mark-next-like-this-word)
(keymap-global-set "C-S-a" 'mc/mark-all-like-this)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("f654d73d7a0761cc4f7d99fffe4b16fce1b2d95844f37bc786e455cec744ac75" "972f792651d32b0506481b9e87b2fbc9b732ae9da2527562668c6e7d149fefda" default))
 '(package-selected-packages '(visible-mark zenburn-theme multiple-cursors)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Deja Vu Sans Mono" :slant normal :weight regular :height 110 :width normal)))))
