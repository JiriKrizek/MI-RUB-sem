require '../lib/tokenizer.rb'
require '../lib/invalid_token_error.rb'
require '../lib/invalid_tag_error.rb'
require '../lib/tags/html_node.rb'
require '../lib/tags/head_node.rb'
require '../lib/tags/title_node.rb'

module HTML
  class Parser
    attr_accessor :string

    def initialize
      @tags_map = {
        :html => HTML::Tags::HtmlNode,
        :head => HTML::Tags::HeadNode,
        :title => HTML::Tags::TitleNode
      }
    end

    def parse 
      tok = Tokenizer.new(string)
      tags = tok.tokenize

      #print_tags(tags)

      tags.each do |t|
        sym = t.tagname.to_sym
        p "Sym: #{sym}"
        if @tags_map.has_key?(sym)
          mytag = @tags_map[sym].new(t)
          p "#{mytag}: #{mytag.class} #{mytag.ending}"
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