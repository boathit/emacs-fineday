;; This is the package sources we would like to use
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
;			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; Show line number
(global-linum-mode)

;; Set font size as 14pt
(set-face-attribute 'default nil :height 140)

;; Set initial and default frame size
(setq initial-frame-alist '((top . 0) (right . 100) (width . 100) (height . 45)))
(setq default-frame-alist '((top . 0) (right . 100) (width . 100) (height . 45)))

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

;; Set tab as global completion
(setq tab-always-indent 'complete)


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

;; Better clear screen with Ctrl-L
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(add-hook 'eshell-mode-hook
	  '(lambda()
	     (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

;; Auto-Complete
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20160416.604/dict")
(ac-config-default)
;; Trigger ac only when pressing TAB
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

;; --------------------------------------------------------------------------
;; Language mode

;; Julia mode, available in github
;(add-to-list 'load-path "~/.emacs.d/elpa/")
;(require 'julia-mode)

;; Using ess-julia-mode to support completion
(load "~/Github/ESS/lisp/ess-site")
(setq inferior-julia-program-name "julia")

(define-key ess-julia-mode-map (kbd "TAB") 'julia-latexsub-or-indent)
(global-set-key (kbd "<C-tab>") 'julia-latexsub-or-indent)

;; ---------------------------------------------------------------------------

;; Clojure mode [package-install clojure-mode]
(require 'clojure-mode)

;; Org setting
(setq org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
