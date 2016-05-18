;; This is the package sources we would like to use
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Show line number
(global-linum-mode)

;; Set font size as 14pt
(set-face-attribute 'default nil :height 140)

;; Set initial and default frame size
(setq initial-frame-alist '((top . 0) (right . 150) (width . 150) (height . 55)))
(setq default-frame-alist '((top . 0) (right . 150) (width . 150) (height . 55)))

;; Use monokai theme, available in github (https://github.com/owainlewis/emacs-color-themes)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; Backup and autosave in one place. flat, no tree structure
(setq backup-directory-alist
      `((".*" . ,"~/.emacs.d/emacs-backup")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/emacs-backup" t)))

;; Enable auto indent
(electric-indent-mode 1)

;; Highlight matching parentheses
(show-paren-mode 1)


;; ------------------------------------------------------------------------
;; Commonly used packages

(package-initialize)

;; Copy executable path from shell [package-install exec-path-from shell]
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; Comment these two lines if you don't have Gurobi and Mosek license
(exec-path-from-shell-copy-env "GRB_LICENSE_FILE")
(exec-path-from-shell-copy-env "MOSEKLM_LICENSE_FILE")


;; Colorize delimiters [package-install rainbow-delimiters]
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;; --------------------------------------------------------------------------
;; Language mode

;; Julia mode, available in github
(add-to-list 'load-path "~/.emacs.d/elpa/")
(require 'julia-mode)

;; Julia shell, available in github
(add-to-list 'load-path "~/.emacs.d/elpa/julia-shell-mode/")
(require 'julia-shell)
;; Interact with julia-mode
(defun my-julia-mode-hooks ()
  (require 'julia-shell-mode))
(add-hook 'julia-mode-hook 'my-julia-mode-hooks)
(define-key julia-mode-map (kbd "C-c C-c") 'julia-shell-run-region-or-line)
(define-key julia-mode-map (kbd "C-c C-s") 'julia-shell-save-and-go)

;; ---------------------------------------------------------------------------

;; Clojure mode [package-install clojure-mode]
(require 'clojure-mode)

