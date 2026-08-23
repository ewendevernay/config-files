(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(dolist (p '(multiple-cursors swiper zenburn-theme visible-mark plantuml-mode ess flycheck))
  (when (not (package-installed-p p))
    (package-install p)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)
(setq make-backup-files nil)

(ido-mode 1)

(keymap-global-set "<backtab>" 'indent-region)

(keymap-global-set "<f6>" 'gud-cont)
(keymap-global-set "<f7>" 'gud-step)
(keymap-global-set "<f8>" 'gud-next)
(keymap-global-set "<f5>" 'compile)
(keymap-global-set "M-s" 'swiper)

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

(setq-default compile-command "./build.sh && ./")

(keymap-global-set "M-<up>" 'move-text-up)
(keymap-global-set "M-<down>" 'move-text-down)

(global-auto-revert-mode 1)
(setq auto-revert-interval 0)
(setq global-auto-revert-non-file-buffers t)

(setq transient-mark-mode nil)

(setq visible-mark-max 1)
(global-visible-mark-mode 1)

(require 'multiple-cursors)
(global-set-key (kbd "M-S-<down>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-S-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this-symbol)
(global-set-key (kbd "C-S-a") 'mc/mark-all-like-this)

(add-to-list 'load-path "~/.emacs.d/idris2-mode/")
(require 'idris2-mode)

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (c-set-style "k&r")
;;             (setq indent-tabs-mode t)
;; 	    (setq tab-width 1)
;; 	    (local-set-key (kbd "C-d") 'mc/mark-next-like-this-symbol)
;;             (setq c-basic-offset tab-width)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "k&r")
	    (setq c-basic-offset 1)
	    (setq-local indent-tabs-mode nil)
	    (local-set-key (kbd "C-d") 'mc/mark-next-like-this-symbol)))

(windmove-default-keybindings)

(setq gdb-many-windows 1)

(global-set-key (kbd "<f9>") 'gdb)
(add-hook 'gud-mode-hook
          (lambda ()
             (global-set-key (kbd "<f7>") 'gud-next)
             (global-set-key (kbd "<f8>") 'gud-step)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("f654d73d7a0761cc4f7d99fffe4b16fce1b2d95844f37bc786e455cec744ac75" "972f792651d32b0506481b9e87b2fbc9b732ae9da2527562668c6e7d149fefda" default))
 '(package-selected-packages
   '(ess plantuml-mode swiper visible-mark zenburn-theme multiple-cursors)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack Nerd Font Mono" :slant normal :weight regular :height 110 :width normal)))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
