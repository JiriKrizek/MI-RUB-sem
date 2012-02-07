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
              if valid_token?(tagname)
                if ending?(tagname) && count_attr(tagname)!=0
                  fail HTML::InvalidTokenError.new("Ending HTML tag #{tagname} can't have attributes")
                else
                  parse_attr(tagname) 
                end
              else
                fail HTML::InvalidTokenError.new("Could not parse tag #{tagname}, invalid tag ")
              end
              print "emit tag token '#{tagname}'"

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

    def ending?(token)
      token[0]=='/'
    end

    def count_attr(token)
      token.split(' ').length-1
    end

    def parse_attr(token)
      result = Hash.new
      
      # oriznout nazev tagu
      t = token.split(' ', 2)
      tagname = t.shift
      attributes = t[0]

      # pokud mame nejake atributy, parsujeme je
      if attributes
        state_attr = :read_key
        inquotes = false

        k = ""
        val = ""
        attributes.each_char do |ch|
          puts "char: #{ch}"
          # Cteme klic, povolujeme jen vyskyt znaku = kdyz mame hodnotu a nebo ' ' pro atributy bez hodnoty, 
          # napr. kdybychom chteli rozlisit <input disabled>
          if state_attr == :read_key
            if ch=='='
              # Consume =
              state_attr = :read_value
            elsif ch=='"'
              fail InvalidTokenError.new("Could not parse tag #{tagname}, (probably missing '=' in attribute)")
            elsif ch==' ' 
              unless k.empty?
                puts "Result key: '#{k}' = nil"
                result[k] = nil
                k=""
                val=""
              end
            else
              k << ch
            end
          elsif state_attr == :read_value
            if ch=='='
              fail InvalidTokenError.new("Could not parse tag #{tagname}")
            elsif ch=='"'
              inquotes = !inquotes
              # consume
              if ! inquotes
                result[k] = val
                puts "Result key: '#{k}' = '#{val}'"
                k=""
                val=""
                state_attr = :read_key
              end
            else
              if inquotes
                val << ch
              else

              end
            end
          end
        end
        #while splitted_atr[0] do
          #key = splitted_atr.shift
          #value = splitted_atr.shift 
          #result[key] = value
        #end
      end
      #p attributes.split("\"")
      #t.each do |att|
        # v = att.split('=')
        
        # if v.length != 1 && v.length != 2
        #   fail HTML::InvalidTokenError.new("Could not parse tag <#{tagname}>, invalid attributes")
        # end

        # if v.length == 2 
        #   fail HTML::InvalidTokenError.new("Could not parse tag <#{tagname}>, attribute value is not properly quoted") unless v[1][0]=='"' && v[1][-1]=='"'
        # end

        # p v
      #end

      puts "Result: #{result}"
      result
    end
  end
end