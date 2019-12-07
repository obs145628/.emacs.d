;; Emacs configuration for C++, following tutorial
;; http://syamajala.github.io/c-ide.html

;; To setup it for a new project, we need to do:
;; $ rdm & (you should run it on another terminal to avoid info display);
;; $ cd /path/to/project/root;
;; $ cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=1;
;; $ rc -J .
;; Generate clang - format config file: (not needec with extension for clang-format)
;; clang-format -style=llvm -dump-config > .clang-format 




(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; fix the invalid signature issue
(setq package-check-signature nil)

;; === Setup before ====

;; Install LLVM from repos: sudo apt-get install clang libclang-dev

;; Install LLVM from source
;; git repo: https://github.com/llvm/llvm-project
;; cmake ../llvm/ -DCMAKE_INSTALL_PREFIX=/home/obs/local/llvm10/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld"
;; (clang-tools-extra is for tools such as clang-format, clang-tidy, ect)
;; (lld is for the linker)
;; make
;; make install


;; Install Rtags (2.34)
;; Dependencies: LLVM
;;
;; compile from source: https://github.com/Andersbakken/rtags:
;; git clone --branch v2.34 --recursive https://github.com/Andersbakken/rtags.git
;; LIBCLANG_LLVM_CONFIG_EXECUTABLE=/home/obs/local/llvm10/bin/llvm-config cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
;; make

;; Install emacs package:
;; - rtags
;; - company-rtags
;; - helm-rtags
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

;; TODO: change to clang path
(setq company-clang-executable "/home/obs/local/llvm10/bin/clang")


;; === Syntax checking flycheck ===

;; TODO: change to clang path
(setq-default flycheck-c/c++-clang-executable "/home/obs/local/llvm10/bin/clang")

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



;; === clang-format ====


;; TODO: change path to clang-format.el
(load "/home/obs/local/llvm10/share/clang/clang-format.el")

(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)
;; TODO: change path to clang-format binary
(setq clang-format-executable "/home/obs/local/llvm10/bin/clang-format")
(setq clang-format-style-option "llvm")

;; Run clang-format when saving file
(defun save-clang-format-setup ()
   (add-hook 'before-save-hook
                              'clang-format-buffer nil 'make-it-local)
   )
(add-hook 'c-mode-common-hook #'save-clang-format-setup)




;; === Emacs config ====


(add-hook 'prog-mode-hook 'linum-mode) ;always display line numbers


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
