# frozen_string_literal: true

class Language
  class Atom
    class Maybe < Atom
      def initialize(parent:)
        @parent = parent
      end

      def parse(parser)
        clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer
          )

        @parent.parse(clone)
      rescue Parser::Interuption
      else
        parser.buffer = clone.buffer
        parser.cursor = clone.cursor
        parser.output = clone.output
      end

      def to_s
        @parent ? "#{@parent}.maybe" : "maybe"
      end
    end
  end
end
