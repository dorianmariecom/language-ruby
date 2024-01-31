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
  end
end

RSpec.describe Language do
  it "works" do
    expect(Code::Parser::Nothing.parse("nothing")).to eq({ nothing: "nothing" })
  end
end
