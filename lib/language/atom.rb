# frozen_string_literal: true

class Language
  class Atom
    def any
      Any.new
    end

    def str(string)
      Str.new(string:)
    end

    def absent
      Absent.new(parent: self)
    end

    def ignore
      Ignore.new(parent: self)
    end

    def maybe
      Maybe.new(parent: self)
    end

    def repeat(minimum = 0, maximum = nil)
      Repeat.new(parent: self, minimum:, maximum:)
    end

    def aka(name)
      Aka.new(parent: self, name:)
    end

    def |(other)
      Or.new(left: self, right: other)
    end

    def >>(other)
      And.new(left: self, right: other)
    end

    def <<(other)
      And.new(left: self, right: other)
    end

    def then(&block)
      Then.new(parent: self, block:)
    end

    def parse(_parser)
      raise NotImplementedError, "#{self.class}#parse"
    end

    def to_s
      raise NotImplementedError, "#{self.class}#parse"
    end

    def inspect
      to_s
    end
  end
end
