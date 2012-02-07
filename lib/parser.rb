require '../lib/tokenizer.rb'

module HTML
  class Parser
    attr_accessor :string

    def initialize
      
    end

    def parse 
      p @string
      tok = Tokenizer.new(string)
      tok.tokenize
    end
  end
end