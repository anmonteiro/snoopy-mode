;;; snoopy.el --- minor mode for number row unshifted character insertion -*- Mode: Emacs-Lisp; lexical-binding: t -*-

;; Copyright (C) 2017 António Nuno Monteiro, Russell McQueeney

;; Author: António Nuno Monteiro <anmonteiro@gmail.com>
;; Version: 0.1.1
;; Package-Requires: ((emacs "24"))
;; Created: 2017-07-29
;; Keywords: lisp

;; Snoopy is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; Snoopy is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with snoopy-mode.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; The currently released version of snoopy-mode is available at
;;;   <https://raw.githubusercontent.com/anmonteiro/snoopy-mode/v0.1.1/snoopy.el>
;;;
;;; The latest version of snoopy-mode is available at
;;;   <https://raw.githubusercontent.com/anmonteiro/snoopy-mode/master/snoopy.el>
;;;
;;; The Git repository for snoopy-mode is available at
;;;   <https://github.com/anmonteiro/snoopy-mode>
;;;
;;; Release notes are available at
;;;   <https://github.com/anmonteiro/snoopy-mode/blob/master/CHANGELOG.md>

;;; Install snoopy-mode by placing `snoopy.el' in `/path/to/elisp', a
;;; directory of your choice, and adding to your .emacs file:
;;;
;;;   (add-to-list 'load-path "/path/to/elisp")
;;;   (autoload 'snoopy-mode "snoopy"
;;;     "Turn on unshifted mode for characters in the keyboard number row."
;;;     t)
;;;
;;; Start Snoopy Mode on the fly with `M-x snoopy-mode RET',
;;; or always enable it in a major mode `M' (e.g., `lisp') with:
;;;
;;;   (add-hook 'M-mode-hook 'snoopy-mode)
;;;
;;; Customize snoopy-mode using `eval-after-load':
;;;
;;;   (eval-after-load 'snoopy
;;;     '(progn
;;;        (define-key snoopy-mode-map (kbd "1")
;;;          (lambda () (insert-char \! 1)))))
;;;
;;; Send questions, bug reports, comments, feature suggestions, &c.,
;;; via email to the author.
;;;

;;; The snoopy minor mode, Snoopy Mode, binds keys in the keyboard's number
;;; row, such as `1', `2', `3', etc, to commands that insert their shifted
;;; versions, e.g. `!', `@' and `#', respectively.
;;;

;;; Code:

(defcustom snoopy-enabled-in-prefix-arg nil
  "When non-nil, enable Snoopy Mode in prefix arguments."
  :group 'snoopy
  :type 'boolean)

(defcustom snoopy-lighter " Snoopy"
  "Mode line lighter for Snoopy Mode."
  :group 'snoopy
  :type 'string)

(defvar snoopy-qwerty-keyboard-digit-layout
  '(("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")
    ("6" . "^")("7" . "&")("8" . "*")("9" . "(")("0" . ")"))
  "Keyboard mapping for qwerty")

(defvar snoopy-azerty-fr-osx-keyboard-digit-layout
  '(("1" . "&")("2" . "é")("3" . "\"")("4" . "'")("5" . "(")
    ("6" . "§")("7" . "è")("8" . "!") ("9" . "ç")("0" . "à"))
  "Keyboard mapping for qwerty")

(defun snoopy-insert-char (char)
  "Generate a function that will insert CHAR."
  (lambda ()
    (interactive)
    (insert-char char 1)))

(defun snoopy-make-mode-map (keyboard-digit-layout)
  "Make a mode-map based on KEYBOARD-DIGIT-LAYOUT."
  (let ((map (make-sparse-keymap))
        (open-digit (rassoc "(" keyboard-digit-layout))
        (closed-digit (rassoc ")" keyboard-digit-layout)))

    (defun snoopy-insert-special (_prompt)
      "Insert a special character.

This function is called for opening and
closing parentheses, `9' and `0', to make interaction with other minor
modes such as Paredit work."
      (let* ((cmd-ks (this-command-keys-vector))
             (len (length cmd-ks)))
        (if (and (= len 1)
                 snoopy-mode
                 (or (null prefix-arg)
                     snoopy-enabled-in-prefix-arg))
            (pcase (aref cmd-ks 0)
              ((string-to-char open-digit) (kbd "("))
              ((string-to-char closed-digit) (kbd ")"))
              (?\( (kbd open-digit))
              (?\) (kbd closed-digit)))
          (vector (aref cmd-ks (1- len))))))

    (defun snoopy-define-number-to-char (pair)
      (message "%s" pair)
      (let ((number (car pair))
            (char (cdr pair)))
        (if (and (equal char ")") (equal char "("))
            (define-key input-decode-map (kbd number) 'snoopy-insert-special) ; §FIXME custom logic
            (define-key map (kbd number)
              (snoopy-insert-char (string-to-char char))))))

    (defun snoopy-define-char-to-number (pair)
      (let ((number (car pair))
            (char (cdr pair)))
        (if (and (equal char ")") (equal char "("))
            (define-key input-decode-map (kbd char) 'snoopy-insert-special)
          (define-key map (kbd char)
            (snoopy-insert-char (string-to-char number))))))

    (mapcar 'snoopy-define-number-to-char keyboard-digit-layout)
    (mapcar 'snoopy-define-char-to-number keyboard-digit-layout)

    (define-key map (kbd "<kp-1>") (snoopy-insert-char ?1))
    (define-key map (kbd "<kp-2>") (snoopy-insert-char ?2))
    (define-key map (kbd "<kp-3>") (snoopy-insert-char ?3))
    (define-key map (kbd "<kp-4>") (snoopy-insert-char ?4))
    (define-key map (kbd "<kp-5>") (snoopy-insert-char ?5))
    (define-key map (kbd "<kp-6>") (snoopy-insert-char ?6))
    (define-key map (kbd "<kp-7>") (snoopy-insert-char ?7))
    (define-key map (kbd "<kp-8>") (snoopy-insert-char ?8))
    (define-key map (kbd "<kp-9>") (snoopy-insert-char ?9))
    (define-key map (kbd "<kp-0>") (snoopy-insert-char ?0))
    map))

(defvar snoopy-mode-map (snoopy-make-mode-map snoopy-qwerty-keyboard-digit-layout))
;; (defvar snoopy-mode-map (snoopy-make-mode-map snoopy-azerty-fr-osx-keyboard-digit-layout)) ; WORKING!! ;)


;;;###autoload
(define-minor-mode snoopy-mode
  "Minor mode for number row unshifted character insertion.
With a prefix argument, enable Snoopy Mode.
\\<snoopy-mode-map>"
  :lighter snoopy-lighter
  :group 'snoopy
  :keymap snoopy-mode-map)

(provide 'snoopy)

;;; snoopy.el ends here
