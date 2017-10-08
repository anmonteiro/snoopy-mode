;;; Test for `snoopy-mode'

;;; Commentary:
;; These are the tests for `snoopy-mode'

;;; Code:

(ert-deftest snoopy-mode-should-not-pass ()
  (should-not nil))

(ert-deftest snoopy-mode-make-kdl-assoc-ok ()
  (should
   (equal
    (snoopy-make-keyboard-digit-layout-assoc "&é\"'(§è!çà")
    '(("1" . "&")("2" . "é")("3" . "\"")("4" . "'")("5" . "(")
      ("6" . "§")("7" . "è")("8" . "!") ("9" . "ç")("0" . "à")))))


(ert-deftest snoopy-mode-make-kdl-assoc-ok-2 ()
  (should
   (equal
    (snoopy-make-keyboard-digit-layout-assoc "!@#$%^&*()")
    '(("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")
      ("6" . "^")("7" . "&")("8" . "*")("9" . "(")("0" . ")")))))
