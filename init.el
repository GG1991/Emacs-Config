;;
;; Emacs Configuration File
;;
;; Author: Guido Giuntoli
;;

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

;; Creates a custom file if not exists
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
      
;; Use the Evil-Mode
(require 'evil)                                                               
(evil-mode t) 

;; C Indentation
(setq-default c-default-style
	      '((java-mode . "java")
		(awk-mode . "awk")
		(other . "linux")))

