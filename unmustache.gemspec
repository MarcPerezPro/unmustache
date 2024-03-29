# frozen_string_literal: true

require_relative 'lib/unmustache/version'

Gem::Specification.new do |spec|
  spec.name = 'unmustache'
  spec.version = Unmustache::VERSION
  spec.authors = ['Marc PEREZ']

  spec.summary      = 'Unrenders Mustache templates'
  spec.description  = 'Extracts the variables from rendered Mustache templates'
  spec.homepage     = 'https://rubygems.org/gems/unmustache'
  spec.required_ruby_version = '>= 2.6.0'
  spec.license = 'MIT'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/return-main/unmustache'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Runtime dependencies
  spec.add_runtime_dependency 'cgi'
  spec.add_runtime_dependency 'logger'

  # Development dependencies
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'solargraph'
  spec.add_development_dependency 'yard'

  # Testing dependencies
  spec.add_development_dependency 'mustache'
  spec.add_development_dependency 'rspec'
end
