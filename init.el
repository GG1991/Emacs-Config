;;
;; Emacs Configuration File
;;
;; Author: Guido Giuntoli
;;
;;; Code:

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
;; Nueva optimizacion, crea los autoloads de los paquetes en un solo
;; fichero cuando se instalan. Asi no hay que abrir muchos ficheros
;; sino uno solo. Se nota mucho cuando el disco es mecanico, con ssd
;; apenas hay diferencia.
(setq package-quickstart t)

;; Creates a custom file if not exists
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;; use-package
;; Instalar use-packages si no esta instalado
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; El init.el se puede compilar a bytecode cuando es muy grande o
;; complicado (aunque no es necesario)
;; esto es para que sepa que esto lo tine que hacer en ambos casos

(eval-and-compile
  (setq use-package-always-ensure t          ;; Comprueba si los paquetes estan instalados siempre
	use-package-enable-imenu-support t)

  (require 'use-package)

  ;; Hacer profiling del init.el y activar verbose cuando se abre con --debug-init.
  ;; si no abrir lo mas rapido posible
  (if init-file-debug
      (progn
	(setq use-package-verbose t
	      use-package-expand-minimally nil
	      use-package-compute-statistics t
	      debug-on-error t)
	(use-package benchmark-init
	  :config
	  (add-hook 'window-setup-hook 'benchmark-init/deactivate t)))

    (setq use-package-verbose nil
	  use-package-expand-minimally t)))

;; Con use-package comprueba si el paquete esta instalado,
;; y si no lo instala automaticamente
(use-package evil
  :config
  (evil-mode 1)
  ;; Esta mariconada te gustara.
  (setq original-background "brightblack"
	normal-state-background (face-attribute 'mode-line :background)
	visual-state-background "green")

  (add-hook 'evil-normal-state-entry-hook
	    (lambda ()
	      (set-face-attribute 'mode-line nil :background normal-state-background)))
  (add-hook 'evil-insert-state-entry-hook
	    (lambda ()
	      (set-face-attribute 'mode-line nil :background original-background)))
  (add-hook 'evil-visual-state-entry-hook
	    (lambda ()
	      (set-face-attribute 'mode-line nil :background visual-state-background))))


;; C Indentation
(setq-default c-default-style
	      '((java-mode . "java")
		(awk-mode . "awk")
		(other . "linux")))

;; Esto es buena practica
(provide 'init)
;;; init.el ends here
