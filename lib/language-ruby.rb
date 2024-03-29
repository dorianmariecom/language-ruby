# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/language-ruby.rb")
loader.setup
