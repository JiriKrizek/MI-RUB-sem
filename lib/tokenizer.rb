module HTML
  class Tokenizer
    attr_accessor :string
    def initialize(string)
      @string = string

      @valid_tokens = {"html" => 1, "head" => 1, "body" => 1, "title" => 1, "b" => 1, "i" => 1, "u" => 1, 
                       "br" => 1, "table" => 1, "tr" => 1, "th" => 1, "td" => 1, "h1" => 1, 
                       "h2" => 1, "h3" => 1, "h4" => 1, "h5" => 1, "h6" => 1, "doctype" => 1}
    end

    def emit(char)
      #print char
    end

    def tokenize
      tags = Array.new

      state = :data
      tagname = ""
      endtagname = ""
      data = ""
      @string.each_char { |c|
          if state == :data 
            if c=='<' # consume <; switch to tagopen STATE
              state = :tagopen
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
                if ending?(tagname) && attr_exists?(tagname)!=0
                  fail InvalidTokenError.new("Ending HTML tag #{tagname} can't have attributes")
                else
                  tag = parse_tag(tagname)

                  attributes = parse_attr(tagname)
                  #puts "Tag '#{tag}' has attributes '#{attributes}'"
                  tags << Tag.new(tag, attributes)
                end
              else
                fail InvalidTokenError.new("Could not parse tag #{tagname}, invalid tag ")
              end
              
              tagname = ""
              state = :data
            else
              tagname << c.downcase # consume a-z
            end
          end
      }
      tags
    end

  private
    def valid_token?(token)
      t = token.split(' ')[0].tr('/', '')
      @valid_tokens.key?(t)
    end

    def ending?(token)
      token[0]=='/'
    end

    def attr_exists?(token)
      token.split(' ',2).length-1
    end

    def parse_tag(token)
      t = token.split(' ', 2)
      t.shift
    end

    def parse_attr(token)
      # oriznout nazev tagu
      t = token.split(' ', 2)
      tagname = t.shift
      attributes = t[0]

      # pokud nemame atributy, vracime prazdny hash
      result = Hash.new
      unless attributes
        return result
      else # jinak zacnem parsovat atributy
        # nejdriv cteme klic (nazev atributu)
        state_attr = :read_key
        inquotes = false

        k = ""
        val = ""
        attributes.each_char do |ch|
        # Cteme klic, povolujeme jen vyskyt znaku = kdyz mame hodnotu a nebo ' ' pro atributy bez hodnoty, 
        # napr. kdybychom chteli rozlisit <input disabled>
        if state_attr == :read_key
          if ch=='='
            # Consume =
            state_attr = :read_value
          # Na " bychom nemeli v nazvu tagu narazit, pokud jsme predtim nedostali =, coz nas zmeni do stavu cteni hodnoty atributu
          elsif ch=='"' 
            fail InvalidTokenError.new("Could not parse tag #{tagname}, (probably missing '=' in attribute)")
          elsif ch==' ' # Mame klic bez hodnoty, ulozime a cteme dalsi klic
            unless k.empty?
              result[k] = nil
              k=""
              val=""
            end
          else
            k << ch # Skladame nazev klice
          end
        elsif state_attr == :read_value # Jsme ve stavu nacitani hodnoty
          if ch=='=' # Na znak = bychom nemeli narazit
            fail InvalidTokenError.new("Could not parse tag #{tagname}")
          elsif ch=='"' # Vstupujeme do hodnoty, uvozovky ignorujem
            inquotes = !inquotes
            # consume
            if ! inquotes # Pokud jsme opustili uvozovky, ulozime a vracime se do stavu cteni klice
              result[k] = val
              k=""
              val=""
              state_attr = :read_key
            end
          else
            if inquotes
              val << ch # Skladame hodnotu
            else
              fail InvalidTokenError.new("Could not parse tag #{tagname}, missing value (probably missing '\"')")
            end
          end
        end
        end
      end
      result
    end
  end
end