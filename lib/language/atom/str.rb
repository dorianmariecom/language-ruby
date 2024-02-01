# frozen_string_literal: true

class Language
  class Atom
    class Str < Atom
      def initialize(string:)
        @string = string
      end

      def parse(parser)
        unless parser.next?(@string)
          raise Parser::Str::NotFound.new(parser, @string)
        end

        parser.consume(@string.size)
      end

      def to_s
        "str(#{@string.inspect})"
      end
    end
  end
end
