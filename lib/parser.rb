module HTML
  class Parser
    attr_accessor :string

    def initialize
      @stack = []
    end

    def parse 
      tok = Tokenizer.new(string)
      tags = tok.tokenize

      #print_tags(tags)

      
      tags.each do |t|
        #puts
        sym = t.tagname.to_sym
        #p "Sym: #{sym}"

        if Tag.tags_map.has_key?(sym)
          mytag = Tag.tags_map[sym].new(t)

            #p "Ending #{mytag.tagname}? #{mytag.ending}"
          unless @stack.empty?
            if mytag.ending
              starting = @stack.pop 
            else
              parent = @stack.last
              can_i = parent.can_has?(mytag.class)

              if can_i
                @stack.push(mytag)
              else
                fail HTML::InvalidChildError
              end
            end
          else
            @stack.push(mytag)
          end
        else
          fail HTML::InvalidTagError.new("Invalid tag #{t.tag}, this tag is not supported")
        end
      end
        if (@stack.size == 1 && @stack[0].class == HTML::Tags::DoctypeNode)
          puts "Dokument se zda byt validni\n"
        elsif @stack.size == 0
          puts "Dokument se zda byt validni\n"
        else
          print_tags(tags)
          fail StandardError.new("Dokument neni validni, nebo obsahuje nezname tagy")
        end
    end
    
    def print_tags(tags)
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