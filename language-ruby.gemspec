# frozen_string_literal: true

require "English"
require_relative "lib/language/version"

Gem::Specification.new do |s|
  s.name = "language-ruby"
  s.version = ::Language::Version
  s.summary = "parser dsl"
  s.description = s.summary
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariecom/language-ruby"
  s.license = "MIT"
  s.add_dependency "zeitwerk"
end
