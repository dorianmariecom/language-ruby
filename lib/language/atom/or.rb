# frozen_string_literal: true

class Language
  class Atom
    class Or < Atom
      def initialize(left:, right:)
        @left = left
        @right = right
      end

      def parse(parser)
        left_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer
          )

        right_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer
          )

        begin
          @left.parse(left_clone)
          parser.cursor = left_clone.cursor
          parser.buffer = left_clone.buffer
          parser.output.merge(left_clone.output)
        rescue Parser::Interuption
          @right.parse(right_clone)
          parser.cursor = right_clone.cursor
          parser.buffer = right_clone.buffer
          parser.output.merge(right_clone.output)
        end
      end

      def to_s
        "((#{@left}) | (#{@right}))"
      end
    end
  end
end
