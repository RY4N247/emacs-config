;;Editor Settings
(setq inhibit-startup-screen t) ;; Disable startup screen
;; Global VS Code–style indentation
(setq-default indent-tabs-mode nil)  ;; always use spaces
(setq-default tab-width 4)           ;; 4 spaces everywhere
(setq-default standard-indent 4)     ;; 4 spaces for auto-indent
;;Same indentation for copilot suggestions
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local copilot--indentation-offset tab-width)))


;; Put all backup files in one place
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-saves/" t)))

;; Create directories if they don’t exist
(make-directory "~/.emacs.d/backups" t)
(make-directory "~/.emacs.d/auto-saves" t)


;;Package Management Setup
(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;;Path for when opening through spotlight on mac
(when (memq window-system '(mac ns x))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;;==UI==
(tool-bar-mode -1)
(load-theme 'wheatgrass t)
(use-package treemacs
  :ensure t)

;;==AI Agent==
;;Copilot Bindings - node js required
;;https://github.com/copilot-emacs/copilot.el

(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :branch "main")
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-mode-map
              ("C-<tab>"     . copilot-accept-completion)
              ("C-M-<tab>"   . copilot-accept-completion-by-word)
              ("C-M-S-<tab>" . copilot-accept-completion-by-line)))


;;==Language Support==
;;LSP
(use-package eglot
  :ensure nil)
(add-hook 'python-mode-hook #'eglot-ensure)
;;use pipx to install pyright for python lsp

;;Global Auto Complete
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

;;Agda
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda --emacs-mode locate")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((copilot :url "https://github.com/copilot-emacs/copilot.el" :branch
	      "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
