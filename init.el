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
 '(custom-enabled-themes '(leuven))
 '(delete-by-moving-to-trash t)
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
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-make-backup-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Consolas")))))



(defun load-config ()
  (interactive)
  (find-file "~/.config/emacs/init.el"))
(global-set-key (kbd "C-c d") 'load-config)


(put 'narrow-to-region 'disabled nil)
