# frozen_string_literal: true

class Language
  class Atom
    class Repeat < Atom
      def initialize(parent: nil, minimum: 0, maximum: nil)
        @parent = parent
        @minimum = minimum
        @maximum = maximum
      end

      def parse(parser)
        return unless @parent

        @minimum.times { match(parser) }
        if @maximum.nil?
          begin
            loop { match(parser) }
          rescue Parser::Interuption
          end
        else
          begin
            (@maximum - @minimum).times { match(parser) }
          rescue Parser::Interuption
          end
        end
      end

      def to_s
        minimum = @minimum.zero? ? "" : @minimum.to_s
        maximum = @maximum.nil? ? "" : ", #{@maximum}"
        parenthesis =
          (minimum.empty? && maximum.empty?) ? "" : "(#{minimum}#{maximum})"

        @parent ? "(#{@parent}).repeat#{parenthesis}" : "repeat#{parenthesis}"
      end

      private

      def match(parser)
        clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer
          )

        @parent.parse(clone)

        parser.cursor = clone.cursor
        parser.buffer = clone.buffer
        parser.output << clone.output
      end
    end
  end
end
