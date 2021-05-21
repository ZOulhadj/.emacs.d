;;; init.el --- Initialisation -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Emacs configuration file that is loaded at startup which sets all options
;; and personal customisations.  At the end of the file, we load the custom
;; interface file for final configuration required by Melpa packages.
;;

;;; Code:

;; Startup

(setq
 gc-cons-threshold 100000000
 read-process-output-max (* 1024 1024)
 inhibit-startup-screen t
 initial-scratch-message nil
 custom-file (concat user-emacs-directory "custom.el"))

;; User Interface
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)

(setq
 blink-cursor-mode nil
 column-number-mode t
 ring-bell-function 'ignore)

;; Editing
(setq-default indent-tabs-mode nil)

(global-subword-mode 1)
(delete-selection-mode 1)

(setq
 tab-width 4
 global-auto-revert-mode t
 delete-by-moving-to-trash t
 create-lockfiles nil
 help-window-select t
 select-enable-clipboard t
 kill-whole-line t
 )

;;(ido-mode 1)
;;(setq
;; ido-everywhere t
;; ido-enable-flex-matching t)

(add-hook 'before-save-hook 'whitespace-cleanup)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Backups
(setq
 backup-directory-alist `(("." . "~/.config/emacs/backups"))
 backup-by-copying t
 vc-make-backup-files t)

;; Exiting
(setq
 confirm-kill-emacs 'y-or-n-p
 confirm-kill-processes nil)


;; Enable disabled modes
(put 'narrow-to-region 'disabled nil)

;; Functions
(defun open-configuration ()
  "Load the Emacs configuration file."
  (interactive)
  (find-file (concat user-emacs-directory "init.el")))

;; Keybindings
(global-set-key [f1] 'shell)
(global-set-key (kbd "C-c d") 'open-configuration)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                    ;;
;;     Specific language settings     ;;
;;                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; C
(setq
 c-default-style "bsd"
 c-basic-offset 4
 )

;; HTML
(setq
 sgml-basic-offset 4)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                    ;;
;;     External package settings      ;;
;;                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Packages
(setq package-user-dir (concat user-emacs-directory "packages")
      package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Custom interface only used for listing installed packages
(load custom-file)

;; Initialise packages
(package-initialize)

;; Update package archives
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package is not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package use-package
  :init
  (setq use-package-always-ensure t))

(use-package diminish)

(use-package naysayer-theme
  :config
  (load-theme 'naysayer t))

(use-package dimmer
  :custom
  (dimmer-fraction 0.5)
  :config
  (dimmer-mode))

(use-package which-key
  :config
  (which-key-mode)
  :diminish)

(use-package pandoc-mode
  :hook (
         (markdown-mode . pandoc-mode)
         (pandoc-mode . 'pandoc-load-default-settings)))

(use-package vterm)

(use-package magit
  :bind
  ("C-c g" . #'magit-status))

(use-package company
  :hook
  (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.5
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-require-match nil
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))
  :bind
  (("C-." . #'company-complete)
   (:map company-active-map
         ([tab] . 'company-complete-selection)
         ("RET" . nil)))

  :diminish)


(use-package flycheck
  :hook
  (prog-mode . flycheck-mode)
  :custom
  (flycheck-display-errors-delay 0.1)
  :diminish)

;;; init.el ends here
