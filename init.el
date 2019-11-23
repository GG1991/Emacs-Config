;;
;; Emacs Configuration File
;;
;; Author: Guido Giuntoli
;;

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(global-display-line-numbers-mode t)
(column-number-mode t)
(save-place-mode t) ;; remember place in files
(global-display-fill-column-indicator-mode t)

;; Creates a custom file if not exists
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)


;;----------------------------------------
;; use-package
;;
(unless (package-installed-p 'use-package)
  (require 'package)
  (package-refresh-contents)
  (package-install 'use-package))


;;----------------------------------------
;; git-gutter
;;
(use-package git-gutter
  :ensure t
  :custom
  (git-gutter:modified-sign "  ")
  (git-gutter:added-sign "++")
  (git-gutter:delete-sign "--")
  :config
  (git-gutter)
  (global-git-gutter-mode t)
  (set-face-background 'git-gutter:modified "purple")
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red")
  )


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
  :bind ("<f8>" . neotree-toggle)
  )


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


;;----------------------------------------
;; Dired
;;
(require 'dired)

(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

(put 'dired-find-alternate-file 'disabled nil)
