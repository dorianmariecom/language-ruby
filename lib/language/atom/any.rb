# frozen_string_literal: true

class Language
  class Atom
    class Any < Atom
      def parse(parser)
        parser.consume(1)
      end

      def to_s
        "any"
      end
    end
  end
end
