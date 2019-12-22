
;; RUST Programming env

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)
(setq package-check-signature nil)




;; emacs package to install:
;; - use-package
;; - yasnippet
;; - flycheck
;; - company
;; - lsp-mode
;; - lsp-ui
;; - toml-mode
;; - rust-mode
;; - cargo
;; - flycheck-rust

(require 'yasnippet)

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1))

(use-package lsp-mode
  :commands lsp
  :config (require 'lsp-clients))

(use-package lsp-ui)




(use-package toml-mode)

(use-package rust-mode
  :hook (rust-mode . lsp))


;; run rustftm when saving buffer
(setq rust-format-on-save t)


;; Add keybindings for interacting with Cargo
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rust-mode flycheck-rust toml-mode lsp-ui lsp-mode use-package racer flycheck company cargo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
