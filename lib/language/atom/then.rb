# frozen_string_literal: true

class Language
  class Atom
    class Then < Atom
      def initialize(parent:, block:)
        @parent = parent
        @block = block
      end

      def parse(parser)
        @parent.parse(parser)

        if parser.output.nil?
          parser.buffer = @block.call(parser.buffer)
        else
          parser.output = Output.from_raw(@block.call(parser.output.to_raw))
        end
      end

      def to_s
        "(#{@parent}).then {}"
      end
    end
  end
end
