# frozen_string_literal: true

class Language
  class Parser
    attr_accessor :input, :buffer, :output, :root, :cursor

    def initialize(root:, input:, cursor: 0, buffer: "", output: Output.new)
      @root = root
      @input = input
      @cursor = cursor
      @buffer = buffer
      @output = output
    end

    def parse(check_end_of_input: true)
      @root.parse(self)

      unless @cursor == @input.size || !check_end_of_input
        raise NotEndOfInput, self
      end

      if @output.present?
        @output
      else
        Output.new(@buffer.empty? ? nil : @buffer)
      end
    end

    def consume(n)
      raise EndOfInput, self unless @cursor + n <= @input.size

      @buffer += @input[@cursor, n]
      @cursor += n
    end

    def aka(name)
      if @buffer.empty?
        @output = Output.new({ name => @output })
      else
        @output[name] = Output.new(@buffer)
        @buffer = ""
      end
    end

    def next?(string)
      @input[@cursor...(@cursor + string.size)] == string
    end

    def buffer?
      @buffer != ""
    end

    def output?
      @output.present?
    end
  end
end
