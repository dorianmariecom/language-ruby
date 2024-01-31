# frozen_string_literal: true

class Language
  class Atom
    class Aka < Atom
      def initialize(name:, parent:)
        @name = name
        @parent = parent
      end

      def parse(parser)
        clone =
          Parser.new(root: self, input: parser.input, cursor: parser.cursor)

        @parent.parse(clone)

        if clone.output?
          parser.output = Output.new(@name => clone.output)
        else
          parser.output[@name] = Output.new(clone.buffer)
          parser.buffer = ""
        end

        parser.cursor = clone.cursor
      end

      def to_s
        @parent ? "#{@parent}.aka(#{@name.inspect})" : "aka(#{@name.inspect})"
      end
    end
  end
end
