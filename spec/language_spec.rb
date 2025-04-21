# frozen_string_literal: true

class Code
  class Parser
    class Nothing < Language
      def nothing_keyword
        str("nothing")
      end

      def root
        nothing_keyword.aka(:nothing)
      end
    end

    class ThenWithBuffer < Language
      def root
        any.repeat(1).then { "something-else" }
      end
    end

    class ThenWithBufferTransformed < Language
      def root
        any.repeat(1).then(&:upcase)
      end
    end

    class ThenWithOutput < Language
      def root
        any
          .repeat(1)
          .aka(:something)
          .then { |output| output[:something].upcase }
      end
    end

    class BooleanPresent < Language
      def root
        (
          str("t").aka(:boolean) << str(" ").present << str(" ") <<
            str("rest").aka(:string)
        ) | str("trest").aka(:string)
      end
    end
  end
end

RSpec.describe Language do
  it "works with nothing" do
    expect(Code::Parser::Nothing.parse("nothing")).to eq({ nothing: "nothing" })
  end

  it "works with then with buffer" do
    expect(Code::Parser::ThenWithBuffer.parse("something")).to eq(
      "something-else"
    )
  end

  it "works with then with buffer transformed" do
    expect(Code::Parser::ThenWithBufferTransformed.parse("something")).to eq(
      "SOMETHING"
    )
  end

  it "works with then with output" do
    expect(Code::Parser::ThenWithOutput.parse("value")).to eq("VALUE")
  end

  it "works with present (string)" do
    expect(Code::Parser::BooleanPresent.parse("trest")).to eq(
      { string: "trest" }
    )
  end

  it "works with present (boolean and string)" do
    expect(Code::Parser::BooleanPresent.parse("t rest")).to eq(
      { boolean: "t", string: "rest" }
    )
  end
end
