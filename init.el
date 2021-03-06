;;
;; Emacs Configuration File
;;
;; Author: Guido Giuntoli
;;

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(global-display-line-numbers-mode t)
(auto-fill-mode t)
(column-number-mode t)
(show-paren-mode t)
(save-place-mode t) ;; remember place in files
(global-display-fill-column-indicator-mode t)

(setq inhibit-startup-screen t
      inhibit-startup-message t)


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

(eval-and-compile
  (setq use-package-enable-imenu-support t)

  (require 'use-package)

   (if init-file-debug
      (progn
	(setq use-package-verbose t
	      use-package-expand-minimally nil
	      use-package-compute-statistics t
	      debug-on-error t
	))

    (setq use-package-verbose nil
	  use-package-expand-minimally t))
)


;;----------------------------------------
;; CMake
;;
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\(.in\)?\\'")
  )

(use-package cmake-font-lock
  :ensure t
  :preface
  (defun my/cmake-font-lock ()
    (cmake-font-lock-setup)
    (font-lock-refresh-defaults))
  :init
  (add-hook 'cmake-mode-hook #'my/cmake-font-lock t)
  ;;(add-hook 'cmake-mode-hook #'cmake-font-lock-activate)
  )


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
  (setq evil-want-C-u-scroll t)
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
;; Flyspell
;;
(use-package flyspell
  :ensure t
  ;;:hook ((prog-mode . flyspell-prog-mode)
  ;;	 (text-mode . flyspell-mode))
  :hook (text-mode . flyspell-mode)
  :config
  (setq ispell-dictionary "english")
  :bind (:map flyspell-mode-map
	      ("C-c f b" . flyspell-buffer)
	      ("C-c f r" . flyspell-region)
	      ("C-c f n" . flyspell-goto-next-error)
  )
  )


;;----------------------------------------
;; Langtool
;;
(use-package langtool
  :ensure t
  :defer t
  :config
  (setq langtool-default-language "en")
  (setq langtool-language-tool-jar "~/.emacs.d/LanguageTool-4.7/languagetool-commandline.jar")
  :bind 
  ("C-c l b" . langtool-check-buffer)
  ("C-c l r" . langtool-check)
  )

;;----------------------------------------
;; Clip
;;
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

;;----------------------------------------
;; Mouse
;;
(use-package mouse
  :config
  (xterm-mouse-mode t)
  )
  
;;----------------------------------------
;; Dired
;;
(require 'dired)

(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

(put 'dired-find-alternate-file 'disabled nil)
