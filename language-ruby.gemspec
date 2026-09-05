# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "language-ruby"
  s.version = File.read("VERSION").strip
  s.summary = "parser dsl"
  s.description = s.summary
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ["lib"]
  s.executables << "language"
  s.homepage = "https://github.com/dorianmariecom/language-ruby"
  s.license = "MIT"
  s.add_dependency "dorian-arguments", ">= 2.0.1", "< 3"
  s.add_dependency "zeitwerk", ">= 2.8.3", "< 3"
  s.metadata["rubygems_mfa_required"] = "true"
  s.required_ruby_version = ">= 4.0"
end
