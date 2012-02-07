module HTML
  class Tokenizer
    attr_accessor :string
    def initialize(string)
      @string = string

      @valid_tokens = {"html" => 1, "head" => 1, "body" => 1, "title" => 1, "b" => 1, "i" => 1, "u" => 1, 
                       "br" => 1, "table" => 1, "tr" => 1, "th" => 1, "td" => 1, "h1" => 1, 
                       "h2" => 1, "h3" => 1, "h4" => 1, "h5" => 1, "h6" => 1}
    end

    def emit(char)
      print char
    end

    def tokenize
      state = :data
      tagname = ""
      endtagname = ""
      data = ""
      p "tokenizing"

      @string.each_char { |c|
          if state == :data 
            if c=='<' # consume <; switch to tagopen STATE
              state = :tagopen
              puts
            else # else consume a-z; emit character token
              data << c
              emit(c)
            end
          elsif state == :tagopen 
            if(c=='/') # consume /; create new end tag open
              tagname = "/"
              state = :closetagopen
            elsif c.downcase=~ /[a-z]/
              tagname << c.downcase
              state = :tagname
            end
          elsif state == :closetagopen
            tagname << c.downcase
            state = :tagname
          elsif state == :tagname
            if(c=='>')
              puts "emit tag token '#{tagname}'"
              p valid_token?(tagname)

              tagname = ""
              state = :data
            else
              tagname << c.downcase # consume a-z
            end
          end
      }
    end

  private
    def valid_token?(token)
      t = token.split(' ')[0].tr('/', '')
      @valid_tokens.key?(t)
    end
  end
end