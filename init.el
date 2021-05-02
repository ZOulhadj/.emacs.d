(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(backup-directory-alist '(("" . "~/.config/emacs/backups")))
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(confirm-kill-emacs 'y-or-n-p)
 '(confirm-kill-processes nil)
 '(create-lockfiles nil)
 '(cursor-in-non-selected-windows nil)
 '(custom-enabled-themes '(manoj-dark))
 '(delete-by-moving-to-trash t)
 '(gc-cons-threshold 100000000)
 '(global-auto-revert-mode t)
 '(global-subword-mode t)
 '(help-window-select t)
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message "zakariya")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(package-selected-packages '(company flycheck lsp-mode which-key pandoc-mode))
 '(package-user-dir "~/.config/emacs/packages")
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(vc-make-backup-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Consolas")))))


(setq read-process-output-max (* 1024 1024))

;; Initialise packages
(package-initialize)
(package-refresh-contents)


(which-key-mode)


(global-flycheck-mode)

(global-company-mode)

(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)

(setq lsp-keymap-prefix "C-c l")
(setq lsp-log-io nil)
(setq lsp-enable-links nil)
(setq lsp-signature-render-documentation nil)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-doc-enable nil)
(setq lsp-completion-enable-additional-text-edit nil)
(setq web-mode-enable-current-element-highlight t)

;; Enable disabled modes
(put 'narrow-to-region 'disabled nil)

;; Functions
(defun open-configuration ()
  (interactive)
  (find-file "~/.config/emacs/init.el"))

;; Keybindings
(global-set-key (kbd "C-c d") 'open-configuration)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Hooks
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Replace all yes or no question with y or n
(defalias 'yes-or-no-p 'y-or-n-p)
