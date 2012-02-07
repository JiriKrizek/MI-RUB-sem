module HTML
  class Tokenizer
    attr_accessor :string
    def initialize(string)
      @string = string
    end

    def tokenize
      p "tokenizing"
    end
  end
end