(require 'f)

(defvar snoopy-mode-support-path
  (f-dirname load-file-name))

(defvar snoopy-mode-features-path
  (f-parent snoopy-mode-support-path))

(defvar snoopy-mode-root-path
  (f-parent snoopy-mode-features-path))

(add-to-list 'load-path snoopy-mode-root-path)

;; Ensure that we don't load old byte-compiled versions
(let ((load-prefer-newer t))
  (require 'undercover)
  (undercover "*.el"
              (:exclude "*-test.el")
              (:report-file "/tmp/undercover-report.json"))
  (require 'snoopy)
  (require 'espuds)
  (require 'ert))

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
