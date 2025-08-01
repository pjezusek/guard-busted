# Guard::Busted

[![Rubocop](https://github.com/pjezusek/guard-busted/actions/workflows/rubocop.yml/badge.svg)](https://github.com/pjezusek/guard-busted/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/pjezusek/guard-busted/actions/workflows/rspec.yml/badge.svg)](https://github.com/pjezusek/guard-busted/actions/workflows/rspec.yml)
[![codecov](https://codecov.io/gh/pjezusek/guard-busted/branch/master/graph/badge.svg?token=OZYC63B26Y)](https://codecov.io/gh/pjezusek/guard-busted)
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
It searches for test files in the `spec` directory with the pattern `spec/<relative_path_to_file>/<file_name>_spec.lua`.

_EXAMPLE:_<br />
There is a file in the project `some_dir/some_file.lua`.
After making changes to this file, the guard-busted gem will try to run tests located in: `spec/some_dir/some_file_spec.lua`.

_WARNING!:_<br />
Keep in mind that it treats the `src` directory in a special way.
It just does not include `src` in the mentioned pattern.

The gem also supports desktop notifications.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `lib/guard/busted/version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pjezusek/guard-busted.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
