# frozen_string_literal: true

class Language
  class Atom
    class Ignore < Atom
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
        parser.cursor = clone.cursor
      end

      def to_s
        "#{@parent}.ignore"
      end
    end
  end
end
