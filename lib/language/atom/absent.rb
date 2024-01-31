# frozen_string_literal: true

class Language
  class Atom
    class Absent < Atom
      def initialize(parent: nil)
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
        @parent&.parse(clone)
      rescue Parser::Interuption
      else
        raise Parser::Interuption.new(parser, self)
      end

      def to_s
        @parent ? "(#{@parent}).absent" : "absent"
      end
    end
  end
end
