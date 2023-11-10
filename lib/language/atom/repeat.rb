# frozen_string_literal: true

class Language
  class Atom
    class Repeat < Atom
      def initialize(parent:)
        @parent = parent
      end

      private

      attr_reader :parent
    end
  end
end
