;;; test-helper --- Test helper for snoopy-mode

;;; Commentary:
;; test helper inspired from https://github.com/tonini/overseer.el/blob/master/test/test-helper.el

;;; Code:

(require 'f)

(defvar cpt-path
  (f-parent (f-this-file)))

(defvar snoopy-mode-test-path
  (f-dirname (f-this-file)))

(defvar snoopy-mode-root-path
  (f-parent snoopy-mode-test-path))

(defvar snoopy-mode-sandbox-path
  (f-expand "sandbox" snoopy-mode-test-path))

(when (f-exists? snoopy-mode-sandbox-path)
  (error "Something is already in %s. Check and destroy it yourself" snoopy-mode-sandbox-path))

(defmacro within-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(let ((default-directory snoopy-mode-sandbox-path))
     (when (f-exists? snoopy-mode-sandbox-path)
       (f-delete default-directory :force))
     (f-mkdir snoopy-mode-sandbox-path)
     ,@body
     (f-delete default-directory :force)))

(require 'ert)
(require 'el-mock)
(eval-when-compile
  (require 'cl))
(require 'snoopy)

;;; test-helper.el ends here
