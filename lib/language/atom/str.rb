# frozen_string_literal: true

class Language
  class Atom
    class Str < Atom
      def initialize(string:)
        @string = string
      end

      def parse(parser)
        raise Parser::Str::NotFound.new(parser, @string) unless parser.next?(@string)

        parser.consume(@string.size)
      end

      def to_s
        "str(#{@string.inspect})"
      end
    end
  end
end
