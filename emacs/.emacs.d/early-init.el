;;; early-init.el --- Emacs 27+ pre-initialisation config

;;; Commentary:

;; Emacs 27+ loads this file before (normally) calling
;; `package-initialize'.  We use this file to suppress that automatic
;; behaviour so that startup is consistent across Emacs versions.

;;; Code:

(setq package-enable-at-startup nil)

(menu-bar-mode 1)
(scroll-bar-mode 1)
(tool-bar-mode -1)
;; get rid of fringe.
(fringe-mode 0)
;; So we can detect this having been loaded
(provide 'early-init)

;;; early-init.el ends here
