module HTML
  class Tag
    @@tags = {
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

    attr_reader :tag, :attr, :ending, :tagname


    def initialize(tag, attributes)
      @tag = tag
      @attr = attributes 
      @ending = tag[0]=='/'
      
      @ending ? @tagname = tag[1..-1] : @tagname = tag
    end

    def has_attr?
      return !@attr.empty?
    end

    def can_has?(klass)
      $stderr.puts "Warning, tag does not have re-defined can_has? method"
      true
    end

    def to_s
      if has_attr?
        a=" "
        a<<@attr.to_s.chomp 
      end
      print "TAG: <#{@tag}#{a}>"
    end

    # Generic tag accepts everything
    def valid_attributes?
      true
    end

    def self.tags
      @@tags
    end
  end
end