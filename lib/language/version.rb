# frozen_string_literal: true

require_relative "../language"

Language::Version =
  Gem::Version.new(File.read(File.expand_path("../../../VERSION", __FILE__)))
