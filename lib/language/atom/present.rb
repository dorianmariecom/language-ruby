# frozen_string_literal: true

class Language
  class Atom
    class Present < Atom
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
      end

      def to_s
        @parent ? "(#{@parent}).present" : "present"
      end
    end
  end
end
