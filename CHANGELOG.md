# Changelog

## [master](https://github.com/anmonteiro/snoopy-mode/compare/v0.1.1...HEAD) (unreleased)

- Add support for numeric keypads ([#2](https://github.com/anmonteiro/snoopy-mode/pull/2)).
- Don't insert overridden keys in prefix arguments by default ([#1](https://github.com/anmonteiro/snoopy-mode/issues/1)).
The fix introduces a custom variable, `snoopy-enabled-in-prefix-arg`, that when
non-nil enables `snoopy-mode` in prefix arguments.
- Add support for international keyboards ([#3](https://github.com/anmonteiro/snoopy-mode/issues/3)).

## [v0.1.1](https://github.com/anmonteiro/snoopy-mode/compare/v0.1.0...v0.1.1) (2017-07-29)

- Fix package description.
- Remove usage of `bound-and-true-p`.

## v0.1.0 (2017-07-29)

- Initial release.
