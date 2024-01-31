# frozen_string_literal: true

class Language
  class Atom
    class And < Atom
      def initialize(left:, right:)
        @left = left
        @right = right
      end

      def parse(parser)
        @left.parse(parser)
        right_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer
          )
        @right.parse(right_clone)
        parser.cursor = right_clone.cursor
        parser.buffer = right_clone.buffer

        parser.output.merge(right_clone.output)
      end

      def to_s
        "#{@left} >> #{@right}".to_s
      end
    end
  end
end
