require 'rails_helper'

describe String do
  describe "#<<" do
    example '文字の追加' do
      s = "ABC"
      s << "D"
      expect {s << nil}.to raise_error(TypeError)
    end

    example 'nilの追加',:exception do
      s = "ABC"
      s << nil
      expect(s.size).to eq(4)
    end
  end
end
