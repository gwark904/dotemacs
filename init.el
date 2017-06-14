;;; init.el --- The first thing GNU Emacs runs

;; Do NOT run garbage collection during startup by setting the value super high.
;; This drastically improves `emacs-init-time'. SOURCE= https://redd.it/6h09zh
;; NOTE: We reset this value later.
(setq gc-cons-threshold 999999999999)

;; Ignore default REGEXP checks of file names at startup.
;; This also drastically improves `emacs-init-time'. SOURCE= https://redd.it/6h09zh
;; NOTE: Some bogus, benign errors will be thrown due to this...
(let ((file-name-handler-alist nil))

  ;; Set up package.el for use with MELPA.
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

  ;; Bootstrap `use-package'.  It will manage all other packages.
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  ;; Reduce load time of `use-package'.
  (eval-when-compile
    (require 'use-package))
  (require 'diminish) ; allows for easy removal of packages' modeline strings
  (require 'bind-key) ; simplifies how keybindings are set

  ;; Tangle and load the rest of the config.
  (org-babel-load-file "~/.emacs.d/config.org")

  ;; Load private-ish settings if they exist
  (if (file-exists-p "~/Dropbox/.private.org")
      (org-babel-load-file "~/Dropbox/.private.org")))

;; Revert garbage collection behavior to a normal, more modern level.
(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold 20000000))) ; magnars' recommendation


;; Prevent Emacs clutter by moving backup/autosave files to system's tempdir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Prevent customization settings from appending junk to this file.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;;; init.el ends here
