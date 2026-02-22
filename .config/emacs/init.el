;; init.el
(defvar my-main-font "Hack Nerd Font")
(push '(fullscreen . maximized) default-frame-alist)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Rainbow Delimiters
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Dirvish
(unless (package-installed-p 'dirvish)
  (package-install 'dirvish))
(dirvish-override-dired-mode)

;; Basic Settings
(setq default-directory "~/"
      completion-ignore-case t
      completions-detailed t
      completions-format 'one-column
      delete-by-moving-to-trash t
      delete-selection-mode nil
      display-line-numbers-widen t
      display-line-numbers-width 3
      scroll-conservatively 101
      scroll-margin 10
      inhibit-startup-message t
      initial-scratch-message nil
      visible-bell t
      create-lockfiles nil
      make-backup-files nil
      backup-inhibited t
      pixel-scroll-precision-mode t)

(load-theme 'leuven-dark t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

(add-to-list 'default-frame-alist
             (cons 'font my-main-font))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#ffffff"))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#ffffff" :font my-main-font :height 1.6 :underline nil))))
 '(org-level-1 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font :height 1.5))))
 '(org-level-2 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font :height 1.3))))
 '(org-level-3 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font :height 1.2))))
 '(org-level-4 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font :height 1.1))))
 '(org-level-5 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font))))
 '(org-level-6 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font))))
 '(org-level-7 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font))))
 '(org-level-8 ((t (:weight bold :foreground "#ffffff" :background nil :overline nil :font my-main-font))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red" :height 1.25))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "blue"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "lightblue"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-unmatched-face ((t (:background "blue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
