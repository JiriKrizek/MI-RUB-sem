require '../lib/tokenizer.rb'
require '../lib/invalid_token_error.rb'
require '../lib/invalid_tag_error.rb'
require '../lib/tags.rb'

module HTML
  class Parser
    attr_accessor :string

    def initialize
      @tags_map = {
        :html  => HTML::Tags::HtmlNode,
        :head  => HTML::Tags::HeadNode,
        :body  => HTML::Tags::BodyNode,
        :title => HTML::Tags::TitleNode,
        :b     => HTML::Tags::BNode,
        :i     => HTML::Tags::INode,
        :u     => HTML::Tags::UNode,
        :br    => HTML::Tags::BrNode,
        :h1    => HTML::Tags::H1Node,
        :h2    => HTML::Tags::H2Node,
        :h3    => HTML::Tags::H3Node,
        :h4    => HTML::Tags::H4Node,
        :h5    => HTML::Tags::H5Node,
        :h6    => HTML::Tags::H6Node,
        :table => HTML::Tags::TableNode,
        :th    => HTML::Tags::ThNode,
        :tr    => HTML::Tags::TrNode,
        :td    => HTML::Tags::TdNode,
        :doctype => HTML::Tags::DoctypeNode
      }
      @stack = []
    end

    def parse 
      tok = Tokenizer.new(string)
      tags = tok.tokenize

      #print_tags(tags)

      
      tags.each do |t|
        sym = t.tagname.to_sym
        #p "Sym: #{sym}"
        if @tags_map.has_key?(sym)
          mytag = @tags_map[sym].new(t)
          
          @stack.push(mytag)
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