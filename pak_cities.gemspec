# frozen_string_literal: true

require_relative "lib/pak_cities/version"

Gem::Specification.new do |spec|
  spec.name = "pak_cities"
  spec.version = PakCities::VERSION
  spec.authors = ["Talha Razzaq"]
  spec.email = ["talha36201@gmail.com"]

  spec.summary = "A Ruby gem for querying Pakistan cities data"
  spec.description = "Provides easy access to Pakistan cities data with powerful query methods."
  spec.homepage = "https://github.com/Talha380/pak_cities"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Talha380/pak_cities"
  spec.metadata["changelog_uri"] = "https://github.com/Talha380/pak_cities/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
