require '../lib/tokenizer.rb'
require '../lib/invalid_token_error.rb'

module HTML
  class Parser
    attr_accessor :string

    def initialize
      
    end

    def parse 
      tok = Tokenizer.new(string)
      tags = tok.tokenize

      indent = 0

      tags.each do |t|
        unless t.ending 
          indent+=1
        end

        indent.times  {|i| print ' '}
        puts t.to_s
        if t.ending
          indent-=1
        end
        
      end
    end
  end
end