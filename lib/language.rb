# frozen_string_literal: true

class Language
  def self.parse(input)
    new.parse(input)
  end

  def self.absent
    Atom::Absent.new(parent: new)
  end

  def self.present
    Atom::Present.new(parent: new)
  end

  def self.ignore
    Atom::Ignore.new(parent: new)
  end

  def self.maybe
    Atom::Maybe.new(parent: new)
  end

  def self.repeat(minimum = 0, maximum = nil)
    Atom::Repeat.new(parent: new, minimum:, maximum:)
  end

  def self.aka(name)
    Atom::Aka.new(parent: new, name:)
  end

  def self.|(other)
    Atom::Or.new(left: new, right: other)
  end

  def self.>>(other)
    Atom::And.new(left: new, right: other)
  end

  def self.<<(other)
    Atom::And.new(left: new, right: other)
  end

  def self.then(&block)
    Atom::Then.new(parent: new, block:)
  end

  def parse(input_or_parser)
    if input_or_parser.is_a?(Parser)
      parser = input_or_parser
      clone =
        Parser.new(
          root:,
          input: parser.input,
          cursor: parser.cursor,
          buffer: parser.buffer,
          output: parser.output
        )

      clone.parse(check_end_of_input: false)

      parser.cursor = clone.cursor
      parser.buffer = clone.buffer
      parser.output = clone.output
    else
      input = input_or_parser
      Parser.new(root:, input:).parse
    end
  end

  def str(string)
    Atom::Str.new(string:)
  end

  def any
    Atom::Any.new
  end

  def to_s
    "<#{self.class.name}>"
  end

  def inspect
    to_s
  end
end
