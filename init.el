;;
;; Emacs Configuration File
;;
;; Author: Guido Giuntoli
;;

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Creates a custom file if not exists
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;;----------------------------------------
;; use-package
;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'package)

(global-display-line-numbers-mode t)
(column-number-mode t)
(save-place-mode t) ;; remember place in files
(global-display-fill-column-indicator-mode t)

;;----------------------------------------
;; git-gutter
;;
(use-package git-gutter
  :ensure t
  :init
  :config
  (git-gutter)
  )

(global-git-gutter-mode t)

(custom-set-variables
 '(git-gutter:modified-sign "  ")
 '(git-gutter:added-sign "++")
 '(git-gutter:delete-sign "--"))

(set-face-background 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;;----------------------------------------
;; evil
;;
(use-package evil
  :ensure t
  :init
  :config
  (evil-mode))

;;----------------------------------------
;; neotree
;;
(use-package neotree
  :ensure t
  :init
  )

(global-set-key [f8] 'neotree-toggle)

;;----------------------------------------
;; C Indentation
;;
(c-add-style "guido-c"
	     '("linux"
	       (fill-column . 80)
	       ))

(setq-default c-default-style
	      '((java-mode . "java")
		(awk-mode . "awk")
		(other . "linux")))

