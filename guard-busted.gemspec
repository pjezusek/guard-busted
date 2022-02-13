# frozen_string_literal: true

require_relative 'lib/guard/busted/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-busted'
  spec.version       = Guard::BustedVersion::VERSION
  spec.authors       = ['Piotr Jezusek']
  spec.email         = ['piotr.jezusek@softbeam.pl']

  spec.summary       = 'Guard gem for busted'
  spec.description   = 'Guard::Busted automatically run your specs'
  spec.homepage      = 'https://github.com/pjezusek/guard-busted.git'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/pjezusek/guard-busted.git'
  spec.metadata['changelog_uri'] = 'https://github.com/pjezusek/guard-busted/blob/master/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard', '~> 2.18'

  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.8'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end
