;; Emacs configuration for C++, Using Irony

;; ### PACKAGES CONFIG ###

; MELPA Setup
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'company)
(require 'company-irony)
(require 'irony)
(require 'flycheck)
(require 'flycheck-irony)


;; ### C/C++ Completion with Irony + Company ###

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

; Instant completion
(setq company-idle-delay 0)

;; ### C/C++ Checker with Flycheck ###

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; ### CLANG-FORMAT ###

; @TODO change to clang-format path
(load "/home/obs/local/llvm10/share/clang/clang-format.el")

; Run clang-format when saving file
(defun save-clang-format-setup ()
   (add-hook 'before-save-hook
                              'clang-format-buffer nil 'make-it-local)
   )
(add-hook 'c-mode-common-hook #'save-clang-format-setup)

;; ### GENERAL CONFIG ###

; always display line numbers
(add-hook 'prog-mode-hook 'linum-mode) 



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (flycheck-irony flycheck company-irony))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
