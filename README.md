# Snoopy Mode
[![MELPA](http://melpa.org/packages/snoopy-badge.svg)](http://melpa.org/#/snoopy)
[![MELPA Stable](http://melpa-stable.milkbox.net/packages/snoopy-badge.svg)](http://stable.melpa.org/#/snoopy)

Snoopy Mode is a minor mode for number row unshifted character insertion in
Emacs.

It can insert characters such as `!` and `@` without pressing the shift key.

## Getting Started

You can install Snoopy Mode from [MELPA](http://melpa.org/).

<kbd>M-x package-install [RET] snoopy [RET]</kbd>

## Usage

Inside Emacs, `M-x snoopy-mode RET` will enable Snoopy Mode.

If you want to enable `snoopy-mode`, e.g. in `prog-mode`, place the following
lines in your Emacs config:

```emacs-lisp
(require 'snoopy)

(add-hook 'prog-mode-hook 'snoopy-mode)
```

## Inspiration

* [This](https://stackoverflow.com/questions/6277813/unshifted-symbols-in-emacs)
StackOverflow question.

## Copyright & License

Copyright © 2017 António Nuno Monteiro, Russell McQueeney

Distributed under the GNU General Public License either version 3, or (at
your option) any later version (see [LICENSE](./LICENSE)).
