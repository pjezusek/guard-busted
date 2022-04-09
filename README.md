# Guard::Busted

[![Rubocop](https://github.com/pjezusek/guard-busted/actions/workflows/rubocop.yml/badge.svg)](https://github.com/pjezusek/guard-busted/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/pjezusek/guard-busted/actions/workflows/rspec.yml/badge.svg)](https://github.com/pjezusek/guard-busted/actions/workflows/rspec.yml)
[![Gem Version](https://badge.fury.io/rb/guard-busted.svg)](https://rubygems.org/gems/guard-busted)

Guard for the unit testing framework named [busted](http://olivinelabs.com/busted/)

## Installation

First you need to install busted.

```bash
luarocks install --local busted
```

Then install this gem using `gem install` command.

```bash
gem install guard-busted
```

## Usage

Just type `guard init busted` in the root of your project.
This command initializes the Guard file.

The provided guard template checks all files with `.lua` extension and starts the corresponding test file.
It searches test files in `spec` directory with the pattern `spec/<relative_path_to_file>/<file_name>_spec.lua`.

_EXAMPLE:_<br />
There is some file in the project `some_dir/some_file.lua`.
After some change on this file the guard-busted gem will try to perform tests located in: `spec/some_dir/some_file_spec.lua`.

_WARNING!:_<br />
Keep in your mind that it treats `src` dir in the special way.
It just does not include `src` in the mentioned pattern.

The gem also supports desktop notifications.

## Contributing

Don't hesitate to open an issue or make a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
