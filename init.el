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
(setq-default
 indent-tabs-mode nil)

(setq
 tab-width 4
 global-subword-mode t
 global-auto-revert-mode t
 delete-by-moving-to-trash t
 create-lockfiles nil
 help-window-select t
 select-enable-clipboard t
 select-enable-primary t
 )

(ido-mode 1)
(setq
 ido-everywhere t
 ido-enable-flex-matching t)

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


(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package use-package
  :init
  (setq use-package-always-ensure t))


(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))


(use-package diminish)


(use-package which-key
  :config
  (which-key-mode)
  :diminish)


(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-links nil
        lsp-signature-render-documentation nil
        lsp-headerline-breadcrumb-enable nil
        lsp-ui-doc-enable nil
        lsp-completion-enable-additional-text-edit nil
        web-mode-enable-current-element-highlight t)
  :hook ((prog-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :diminish)


(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :diminish)


(use-package company
  :hook (prog-mode . company-mode)
  :diminish)


(use-package pandoc-mode
  :hook (
         (markdown-mode . pandoc-mode)
         (pandoc-mode . 'pandoc-load-default-settings)))


(use-package web-mode
  :mode (
         ("\\.html" . web-mode)))


(use-package emmet-mode
  :hook (
         (sgml-mode . emmet-mode)
         (web-mode . emmet-mode)))




;;; init.el ends here
