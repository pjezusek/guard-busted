# Guard::Busted
[![Build Status](https://travis-ci.com/pjezusek/guard-busted.svg?branch=master)](https://travis-ci.com/pjezusek/guard-busted)

Guard for the unit testing framework named [busted](http://olivinelabs.com/busted/)

## Installation

First you need to install busted.

```bash
luarocs install --local busted
```

Then install this gem using `gem install` command.

```bash
gem install guard-busted
```

## Usage

Just type `guard init busted` in the root of your project.
This command initializes the Guard file.

The provided guard template checks all files with `.lua` extension and starts the corresponding test file.
It searches test files in `spec` directory with pattern `spec/<relative_path_to_file>/<file_name>_spec.lua`.
For example if you have file in the project `some_dir/some_file.lua`, the guard-busted gem will starts `spec/some_dir/some_file_spec.lua`.

WARNING!: Keep in your mind that it treats `src` dir in the special way.
It just does not include `src` in the mentioned pattern.


## Contributing

Don't hesistate to open an issue or make a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
