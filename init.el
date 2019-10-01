;; Emacs configuration for C++, following tutorial
;; http://syamajala.github.io/c-ide.html

;; To setup it for a new project, we need to do:
;; $ rdm & (you should run it on another terminal to avoid info display)
;; $ cd /path/to/project/root
;; $ cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=1
;; $ rc -J .

(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; === Setup before ====
;; Install Rtags
;; install deps packages: clang libclang-dev
;; compile from source: https://github.com/Andersbakken/rtags
;; Warning; You need the same version of rtags from melpa and the one you build
;; you can check a package version using C-h P (describe-package) then type the package name

;; Install emacs package:
;; - rtags
;; - company-rtags
;; - flycheck
;; - flycheck-rtags
;; - use-package



;; === Source code navigation with rtags ===

(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)


;; this may be needed if you have an error the protocol versio doesn't match
;; (between melpa rtags and built rtags)
(setq rtags-verify-protocol-version nil)

(require 'helm-rtags)
(setq rtags-use-helm t)


;;enable company in c / c++ mdoe
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; completion without delay
(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)



;; === Syntax checking flycheck ===


(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))

  ;check for errors after x seconds of inactivity
  (rtags-set-periodic-reparse-timeout 0.5)

;c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck company-irony irony helm-rtags company-rtags))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
