;;; init.el --- The first thing GNU Emacs runs

;; Prevent Emacs clutter by moving backup/autosave files to system's tempdir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; init.el ends here
