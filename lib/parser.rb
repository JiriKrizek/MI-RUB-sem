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
        puts
        sym = t.tagname.to_sym
        #p "Sym: #{sym}"

        #p Tag.tags_map
        if Tag.tags_map.has_key?(sym)
          mytag = Tag.tags_map[sym].new(t)

            p "Ending #{mytag.tagname}? #{mytag.ending}"
            #p "Empty stack? #{@stack.empty?}"
          unless @stack.empty?
            if mytag.ending
              print "Stack size: #{@stack.size}"
              starting = @stack.pop 
              puts "aaaaaaaaaaaaaaaa" if starting.tagname == "table"
              puts "TOP: #{starting}"
              puts "Starting tagname: #{starting.tagname}"
              puts "Ending tagname: #{mytag.tagname}" 
              puts "Stack size: #{@stack.size}"
              puts "TOP: #{@stack.last}"
            else
              parent = @stack.last
              can_i = parent.can_has?(mytag.class)

              p "#{parent.tagname} Can-haz? #{mytag.class} #{can_i}"

              if can_i
                @stack.push(mytag)
              else
                p "Tag #{mytag.tagname} can not be child of #{parent.tagname}"
                fail HTML::InvalidChildError
              end
              
              
              
            end
          else
            @stack.push(mytag)
          end


          #p "#{mytag}: #{mytag.class} #{mytag.ending}"
        else
          fail HTML::InvalidTagError.new("Invalid tag #{t.tag}, this tag is not supported")
        end
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